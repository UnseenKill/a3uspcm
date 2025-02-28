#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_canActivate

Description:
    Check if the despawn beacon can be activated.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget] call A3USPCM_despawnbeacon_fnc_canActivate;
    (end example)

Returns:
    Whether the despawn beacon can be activated <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_beacon", objNull, [objNull]]
];

if !assert(!isNull _beacon) exitWith { false };

_beacon getVariable[QGVAR(UAV), objNull] isEqualTo objNull;
