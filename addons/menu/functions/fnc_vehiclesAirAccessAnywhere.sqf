#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_vehiclesAirAccessAnywhere

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
TRACE_1(QFUNCMAIN(vehiclesAirAccessAnywhere),_this);

HR_GRG_Cnd_canAccessAir = { true };

[
    localize LSTRING(Vehicles_AirAccessAnywhereCaption),
    localize LSTRING(Vehicles_AirAccessAnywhereHintDone)
] call A3A_fnc_customHint;

playSound "A3AP_UiSuccess";

nil;
