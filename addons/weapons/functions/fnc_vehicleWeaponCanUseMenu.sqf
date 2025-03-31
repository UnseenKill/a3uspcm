#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleWeaponCanUseMenu

Description:
    Callback for ACE3 interaction menu condition

Parameters:
    0: _player - Player using the self-interaction <OBJECT>

Optional:

Example:

Returns:
    True if the player can use the vehicle weapons menu <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if (isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };
if (objectParent _player isNotEqualTo _vehicle) exitWith { false };

_player isEqualTo gunner _vehicle;
