#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_registerAAGroup

Description:
    Register a group as an AA group and update menu

Parameters:
    0: _group - Group to register <OBJECT>

Optional:

Example:
    (begin example)
    [group player] call A3USPCM_aafc_fnc_registerAAGroup;
    (end example)

Returns:
    Nothing

Scope:
    Server, Unscheduled

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(registerAAGroup),_this);

if !assert(params[
    ["_group", nil, [grpNull]]
]) exitWith {};
if !assert(!isNull _group) exitWith {};
if !assert(isServer) exitWith {};

private _vehicles = [];

units _group apply { objectParent _x } select { !isNull _x } apply {
    if ((_vehicles pushBackUnique _x) isNotEqualTo -1) then {
        _group addVehicle _x;
        _x setVariable[QGVAR(group), _group, true];
    };
};

_group setVariable[QGVAR(vehicles), _vehicles apply { 
    _x addEventHandler["Killed", {
        TRACE_1(QFUNC(vehicleKilled),_this);
    }];

    _x;
}];

_group addEventHandler["Deleted", {
    TRACE_1(QFUNC(groupDeleted),_this);
    GVAR(groups) = GVAR(groups) - [_this select 0];
    publicVariable QGVAR(groups);
}];

_group addEventHandler["VehicleAdded", {
    TRACE_1(QFUNC(vehicleAdded),_this);
    params["_group","_vehicle"];

    _group getVariable QGVAR(vehicles) pushBackUnique _vehicle;
    _vehicle setVariable[QGVAR(group), _group, true];
    publicVariable QGVAR(groups);
}];

GVAR(groups) pushBackUnique _group;
publicVariable QGVAR(groups);

[_group] call FUNC(initReportHandler);

switch GVAR(defaultInitialMode) do {
    case "FC_DEFAULT_ANGRY": {
        units _group apply { _x setUnitCombatMode "YELLOW" };
    };
    case "FC_DEFAULT_CALM": {
        units _group apply { _x setUnitCombatMode "BLUE" };
    };
};

[leader _group, LLSTRING(Message_AARegistered)] remoteExec["sideChat", -2];

nil;
