#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_doCrewStatic

Description:
    Crew vehicles with a gunner.

Parameters:
    0: _vehicles - Array of vehicles to crew

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicles", [], [[]]]
];

if !assert(_vehicles isNotEqualTo []) exitWith {};

private _group = createGroup[independent, true];
private _crewClassKey = ["crewClassName","crewClassNameAI"] select GVAR(moduleMSE_useAI);
private _crewClassType = [configFile >> QGVAR(Config) >> "moduleMSE" >> _crewClassKey, "STRING"] call CBA_fnc_getConfigEntry;

GVAR(groupsCount) = GVAR(groupsCount) + 1;

private _groupName = format["%1 %2-%3",
    [configFile >> QGVAR(Config) >> "moduleMSE" >> "groupName", "STRING"] call CBA_fnc_getConfigEntry,
    [configFile >> QGVAR(Config) >> "moduleMSE" >> "groupPrefix", "NUMBER"] call CBA_fnc_getConfigEntry,
    GVAR(groupsCount)];
private _skill = EGVAR(aafc,aiSkill);
if (_skill isEqualTo 0) then {
    _skill = 0.1 + 0.1 * A3A_rebelSkillMul + 0.015 * skillFIA;
};

TRACE_1(QFUNC(doCrewStatic),_groupName);
_group setGroupIdGlobal[_groupName];

_vehicles apply {
    private _vehicle = _x;

    crew _vehicle apply {
        if (getText(configOf _x >> "simulation") isEqualTo "UAVPilot") then {
            deleteVehicle _x;
        } else {
            [{ _this allowDamage true }, _x, 3.5] call CBA_fnc_waitAndExecute;
            _x allowDamage false;
            moveOut _x;
        };
    };

    fullCrew[_vehicle, "", true] apply {
        _x params["_unit","_role","","_turretPath"];

        if !assert(isNull _unit) then { ERROR_3("%1: non-null unit in %2 slot: %3",_vehicle,_role,_unit); continue; };
        if (_role in["driver","cargo"]) then { TRACE_2(QFUNC(doCrewStatic),_vehicle,_role); continue };

        _unit = _group createUnit[_crewClassType, getPosATL _vehicle, [], 0, "NONE"];
        _unit setSkill _skill;

        switch true do {
            case (_role isEqualTo "gunner");
            case (_role isEqualTo "commander"): {
                TRACE_4(QFUNC(doCrewStatic),_vehicle,_unit,_role,_turretPath);
                _unit moveInTurret[_vehicle, _turretPath];
            };
            default {
                WARNING_3("%1: unhandled crew role %2 for vehicle %3",QFUNC(doCrewStatic),_role,_vehicle);
            };
        };
    };

    _vehicle allowCrewInImmobile true;
    _vehicle setVariable[QGVAR(crewed), true, true];
    _vehicle setVehicleRadar 1;
    _vehicle setVehicleReceiveRemoteTargets true;
    _vehicle setVehicleReportRemoteTargets true;
};

allCurators apply { _x addCuratorEditableObjects[_vehicles, true] };

// Zeus is local, so propagate to server. On the other hand,
// `A3USPCM_zeus_fnc_doCrewStatic` can also be invoked by the server while
// auto-grouping vehicles...
if !(isServer) then {
    [_group] remoteExecCall[QEFUNC(aafc,registerAAGroup), 2];
} else {
    [_group] call EFUNC(aafc,registerAAGroup);
};

if (!GVAR(moduleMSE_useAI) && GVAR(moduleMSE_transferHC)) then {
    [_group] spawn {
        if !assert(params[["_group",grpNull,[grpNull]]]) exitWith {};
        if !assert(!isNull _group) exitWith {};

        uiSleep 5;

        INFO_2("transferring group %1 to HC (theBoss=%2)",_group,theBoss);
        theBoss hcSetGroup[_group];
    };
};

nil;
