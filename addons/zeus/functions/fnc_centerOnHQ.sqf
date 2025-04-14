#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_centerOnHQ

Description:
    Center the Zeus camera on the HQ position.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(centerOnHQ),_this);

if (isNull findDisplay 312) exitWith {};

[curatorCamera, markerPos "Synd_HQ", petros] call FUNCMAIN(utilCenterCamera);

nil;
