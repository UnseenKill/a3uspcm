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

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(registerAAGroup),_this);

params[
    ["_group", grpNull, [grpNull]]
];

if !assert(!isNull _group) exitWith {};

private _vehicles = [];
{
    _vehicles pushBackUnique _x
} forEach (units _group apply { objectParent _x } select { !isNull _x });

_group setVariable[QGVAR(vehicles), _vehicles apply { 
    _x addEventHandler["Killed", {
        TRACE_1(QFUNC(vehicleKilled),_this);
        [] call FUNC(updateMenu);
    }];

    _x;
}];

_group addEventHandler["Deleted", {
    TRACE_1(QFUNC(groupDeleted),_this);
    GVAR(groups) = GVAR(groups) - [_this select 0];
    [] call FUNC(updateMenu);
}];

GVAR(groups) pushBackUnique _group;

[_group] call FUNC(initReportHandler);

switch GVAR(defaultInitialMode) do {
    case "FC_DEFAULT_ANGRY": {
        _group setBehaviour "COMBAT";
        _group setCombatMode "RED";
    };
    case "FC_DEFAULT_CALM": {
        _group setBehaviour "SAFE";
        _group setCombatMode "BLUE";
    };
};

leader _group sideChat localize LSTRING(Message_AARegistered);
[] call FUNC(updateMenu);

nil;
