#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_toggleROE

Description:
    Toggle the ROE for a group

Parameters:
    0: _group - Group to toggle ROE for <OBJECT>/<STRING>
    1: _roe - ROE to set <STRING>

Optional:
    2: _updateMenu - Update the menu <BOOL>

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(toggleROE),_this);

params[
    ["_group", grpNull, [grpNull,""]],
    ["_roe", "", [""]],
    ["_updateMenu", true, [false]]
];

if (_group isEqualType "") then {
    private _index = GVAR(groups) findIf { _group isEqualTo groupId _x };
    if (_index isEqualTo -1) exitWith {
        ERROR_2("%1: Group %2 not found",QFUNC(toggleROE),_group);
    };

    _group = GVAR(groups) select _index;
    if !assert(!isNil "_group") then { _group = grpNull };
};

if !assert(!isNull _group) exitWith {};

switch _roe do {
    case "openFire": {
        _group setCombatMode "RED";
        leader _group sideChat localize LSTRING(Message_ROE_AcceptFire);
    };
    case "holdFire": {
        _group setCombatMode "BLUE";
        leader _group sideChat localize LSTRING(Message_ROE_AcceptHold);
    };
    default {
        ERROR_2("%1: Invalid ROE %2",QFUNC(toggleROE),_roe);
    };
};

if (_updateMenu) then {
    [] call FUNC(updateMenu);
};

nil;
