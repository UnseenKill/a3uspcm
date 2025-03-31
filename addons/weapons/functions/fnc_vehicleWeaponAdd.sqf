#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleWeaponAdd

Description:
    Add vehicle weaponry

Parameters:
    0: _params - Array of parameters <ARRAY>
    1: _player - Player <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(vehicleWeaponAdd),_this);

params[
    ["_params",nil,[[]]],
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _player) exitWith {};
if !assert(!isNil "_params") exitWith {};

_params params[
    ["_vehicle",objNull,[objNull]],
    ["_weapon","",[""]],
    "_path"
];

_vehicle addWeaponTurret[_weapon, _path];

private _modded = _vehicle getVariable[QEGVAR(loadout,moddedTurrets), []];
_modded pushBackUnique _path;
_vehicle setVariable[QEGVAR(loadout,moddedTurrets), _modded, true];

nil;
