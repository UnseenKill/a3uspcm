#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleWeaponCanRemove

Description:
    Callback for ACE3 interaction menu for weapon removal

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player using the interaction <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

assignedVehicleRole _player params["_type","_path"];

if !assert(_type isEqualTo "turret") exitWith { false };

_vehicle currentWeaponTurret _path isNotEqualTo "";
