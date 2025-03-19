#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_canUnpack

Description:
    Check if a packed despawn beacon is in player inventory.

Parameters:
    0: _player - Player object <OBJECT>

Optional:

Example:
    (begin example)
    [ACE_player] call A3USPCM_despawnbeacon_fnc_canUnpack;
    (end example)

Returns:
    Whether the despawn beacon can be unpacked <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _player) exitWith { false };

QGVAR(PackedBeacon) in items _player;
