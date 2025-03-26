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
    ["_idc",nil,[0]]
];

if !assert(!isNil "_idc") exitWith {};

nil;
