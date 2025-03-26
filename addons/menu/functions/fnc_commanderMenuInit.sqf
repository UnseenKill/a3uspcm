#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_commanderMenuInit

Description:
    Initialize controls of A3USPCM injected commander menu tab

Parameters:
    0: _control - tab control <CONTROL>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(commanderMenuInit),_this);

params[
    ["_control",controlNull,[controlNull]]
];

if !assert(!isNull _control) exitWith {};

allControls _control apply {
    TRACE_1(QFUNC(commanderMenuInit),_x);
    _x ctrlSetFade 0;
    _x ctrlCommit 0.3;
};

nil;
