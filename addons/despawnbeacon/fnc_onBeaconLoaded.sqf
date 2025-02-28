#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_onBeaconLoaded

Description:
    Event listener callback when despawn beacon is loaded into a vehicle.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [_object] call A3USPCM_despawnbeacon_fnc_onBeaconLoaded;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onBeaconLoaded),_this);

call FUNC(deactivateBeacon);

nil;
