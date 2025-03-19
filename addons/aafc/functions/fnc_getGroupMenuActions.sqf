#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_getGroupMenuActions

Description:
    Get the menu actions string for a group

Parameters:
    0: _group - Group to get menu actions for <OBJECT>

Optional:

Example:

Returns:
    Menu actions strings <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_group", grpNull, [grpNull]]
];

if !assert(!isNull _group) exitWith {""};

if ({ alive _x } count units _group isEqualTo 0) exitWith {[]};

private _actions = [];

_actions pushBack format["<execute expression='[%1,""openFire""] call %2'>%3</execute>", str groupId _group, QFUNC(toggleROE), localize LSTRING(Menu_ROE_Fire)];
_actions pushBack format["<execute expression='[%1,""holdFire""] call %2'>%3</execute>", str groupId _group, QFUNC(toggleROE), localize LSTRING(Menu_ROE_Hold)];

_actions;
