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

    allTurrets[_vehicle, false] apply {
        private _unit = _group createUnit[_crewClassType, getPosATL _vehicle, [], 0, "NONE"];

        _unit moveInTurret[_vehicle, _x];
        _unit setSkill _skill;

        TRACE_3("Crewed static",_vehicle,_unit,_x);
    };

    _vehicle allowCrewInImmobile true;
    _vehicle setVariable[QGVAR(crewed), true, true];
    _vehicle setVehicleRadar 1;
    _vehicle setVehicleReceiveRemoteTargets true;
    _vehicle setVehicleReportRemoteTargets true;
};

allCurators apply { _x addCuratorEditableObjects[_vehicles, true] };
_this remoteExecCall[QEFUNC(aafc,registerAAGroup), 2];

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
