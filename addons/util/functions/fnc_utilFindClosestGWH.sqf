#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilFindClosestGWH

Description:
    Find the closest GroundWeaponHolder to a given position

Parameters:

Optional:
    0: _position - Position to search from (default: player position) <ARRAY>
    1: _maxDistance - Maximum distance to search for GroundWeaponHolders (default: 10m) <NUMBER>

Example:

Returns:
    Created or found ground weapon holder <OBJECT>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_position", [], [[]]],
    ["_maxDistance", 10, [0]]
];

if (_position isEqualTo []) then {
    _position = getPosATL player;
};

private _gwh = nearestObjects[_position, ["GroundWeaponHolder"], _maxDistance];

if (_gwh isEqualTo []) then {
    _gwh = [createVehicle["GroundWeaponHolder", _position, [], 1, "CAN_COLLIDE"]];
};

_gwh select 0;
