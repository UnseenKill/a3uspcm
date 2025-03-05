#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_autouncompromize_fnc_ucEventHandler

Description:
    A3U "Undercover" event handler

Parameters:
    0: _reason - Reason why UC broke <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(ucEventHandler),_this);

params[
    ["_reason", "", [""]]
];

nil;
