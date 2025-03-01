#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscAirAccessAnywhere

Description:
    Access your air vehicles from any garage

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscAirAccessAnywhere),_this);

HR_GRG_Cnd_canAccessAir = { true };

[
    localize LSTRING(Miscellaneous_AirAccessAnywhereCaption),
    localize LSTRING(Miscellaneous_AirAccessAnywhereHintDone)
] call A3A_fnc_customHint;

playSound "A3AP_UiSuccess";

nil;
