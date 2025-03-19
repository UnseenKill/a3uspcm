#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_autouncompromize_fnc_initializeAutoUncompromize

Description:
    Register A3U "Undercover" event handler

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initializeAutoUncompromize),_this);

["Undercover", QGVAR(EventHandler), FUNC(ucEventHandler)] call A3A_Events_fnc_addEventListener;
[] spawn FUNC(playerCompromizeMonitor);

nil;
