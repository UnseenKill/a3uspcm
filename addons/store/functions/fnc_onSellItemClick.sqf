#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_store_fnc_onSellItemClick

Description:
    Sell button click event handler

Parameters:
    0: _control - Button <CONTROL>

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onSellItemClick),_this);

params[
    ["_control",controlNull,[controlNull]]
];

GVAR(allowAmountAutoUpdate) = nil;

nil;
