#include "script_component.hpp"
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

private _group = createGroup independent;
private _crewClassKey = ["crewClassName","crewClassNameAI"] select GVAR(moduleMSE_useAI);
private _crewClassType = [configFile >> QGVAR(Config) >> "moduleMSE" >> _crewClassKey, "STRING"] call CBA_fnc_getConfigEntry;

GVAR(groupsCount) = GVAR(groupsCount) + 1;

private _groupName = format["%1 %2-%3",
    [configFile >> QGVAR(Config) >> "moduleMSE" >> "groupName", "STRING"] call CBA_fnc_getConfigEntry,
    [configFile >> QGVAR(Config) >> "moduleMSE" >> "groupPrefix", "NUMBER"] call CBA_fnc_getConfigEntry,
    GVAR(groupsCount)];

TRACE_1(QFUNC(doCrewStatic),_groupName);
_group setGroupIdGlobal[_groupName];

[_group] spawn {
    uiSleep 2.5;
    call EFUNC(aafc,registerAAGroup);
};

_vehicles apply {
    crew _x apply {
        _x allowDamage false;
        moveOut _x;
        _x spawn {
            uiSleep 3.5;
            _this allowDamage true;
        };
    };

    [_group, _x, _crewClassType] spawn {
        uiSleep 0.5;
        params["_group","_vehicle","_type"];
        private _unit = _group createUnit[_type, getPosATL _vehicle, [], 0, "NONE"];
        
        _unit moveInGunner _vehicle;
        _unit setSkill 1;
        _vehicle setVariable[QGVAR(crewed), true, true];

        TRACE_2("Crewed static",_vehicle,_unit);

        allCurators apply {
            _x addCuratorEditableObjects[[_vehicle], true];
        };
    };
};

if !(GVAR(moduleMSE_useAI)) then {
    [_group] spawn {
        if !assert(params[["_group",grpNull,[grpNull]]]) exitWith {};
        if !assert(!isNull _group) exitWith {};

        uiSleep 5;

        INFO_2("transferring group %1 to HC (theBoss=%2)",_group,theBoss);
        theBoss hcSetGroup[_group];
        _group setCombatBehaviour "COMBAT";
        _group setCombatMode "RED";
    };
};

nil;
