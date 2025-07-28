#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscRevealLocation

Description:
    Reveals a location on the map.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscRevealLocation),_this);

[1] call A3U_fnc_revealRandomZones;

nil;
