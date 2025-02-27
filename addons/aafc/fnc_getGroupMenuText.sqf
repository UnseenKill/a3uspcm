#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_getGroupMenuText

Description:
    Get the menu text for a group

Parameters:
    0: _group - Group to get menu text for <OBJECT>

Optional:

Example:

Returns:
    Menu text <STRING>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_group", grpNull, [grpNull]]
];

if !assert(!isNull _group) exitWith {""};

private _mode = combatMode _group;
private _vehicles = _group getVariable[QGVAR(vehicles), []];

if (_vehicles isEqualTo []) then {
    _vehicles = "";
} else {
    private _alive = _vehicles select { alive _x };

    if (count _alive isEqualTo count _vehicles) then {
        _vehicles = format["%1x %2 (100%3)", count _vehicles, localize LSTRING(VehicleAbbreviation), "%"];
    } else {
        _vehicles = format["%1/%2 %3 (%4%5)", count _alive, count _vehicles, localize LSTRING(VehicleAbbreviation), round((count _alive / count _vehicles) * 100), "%"];
    };

    _vehicles = format[", %1", _vehicles];
};

format[
    "%1 <font color='%2'>%3</font>%4",
    groupId _group,
    ['#00ff00', '#ff0000'] select (_mode isEqualTo "BLUE"),
    localize([LSTRING(Message_ROE_AcceptFire), LSTRING(Message_ROE_AcceptHold)] select (_mode isEqualTo "BLUE")),
    _vehicles
];
