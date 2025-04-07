#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_onBeaconUnloaded

Description:
    Event listener callback when despawn beacon is unloaded from a vehicle.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [_object] call A3USPCM_despawnbeacon_fnc_onBeaconUnloaded;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onBeaconUnloaded),_this);

nil;
