#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_canPack

Description:
    Check if the despawn beacon can be packed.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [var1] call A3USPCM_despawnbeacon_fnc_canPack;
    (end example)

Returns:
    Whether the despawn beacon can be packed <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_beacon",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith { false };

call FUNC(canActivate);
