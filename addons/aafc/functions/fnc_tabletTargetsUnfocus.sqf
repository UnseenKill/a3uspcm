#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsUnfocus

Description:
    Unfocus event handler for targets tab.

Parameters:
    0: _tabUnfocused - Tab being unfocused <HASHMAP>

Optional:
    1: _tabFocused - Tab being focused <HASHMAP>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
params[
    ["_tabUnfocused", nil, [createHashMap]]
];

if (isNil "_tabUnfocused") exitWith {};
if (_tabUnfocused get "idc" isNotEqualTo IDC_TABHOST_TARGETS) exitWith {};
if !GVAR(trackContacts) exitWith {};

TRACE_1(QFUNC(tabletTargetsUnfocus),_this);

if !isNull(_tabUnfocused get "ctlMap") then {
    (_tabUnfocused get "ctlMap") ctrlShow false;
    (_tabUnfocused get "ctlMap") ctrlEnable false;
};

nil;
