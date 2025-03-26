#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_commanderMenuAction

Description:
    Execute action for commander menu

Parameters:
    0: _idc - IDC of button invoked <CONTROL>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(commanderMenuAction),_this);

params[
    ["_idc",nil,[""]]
];

if !assert(!isNil "_idc") exitWith {};
if !assert(GVAR(cmShortcuts) isEqualType createHashMap) exitWith {};

private _shortcut = GVAR(cmShortcuts) get _idc;

if !assert(!isNil "_shortcut") exitWith {};
if !assert(_shortcut isEqualType []) exitWith {};

TRACE_1(QFUNC(commanderMenuAction),_shortcut);

_shortcut spawn {
    params[["_shortcut",nil,[""]],["_config",configNull,[configNull]]];

    closeDialog 0;
    closeDialog 0;

    waitUntil { isNull findDisplay 60000 };

    GVAR(DiaryConfig) = _config;
    [] call compile format["call %1", _shortcut];
};

nil;
