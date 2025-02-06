#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_serializeLoadout

Description:
    Save vehicle loadout into storable format

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _loadoutName - Loadout name <STRING>

Optional:

Example:
    (begin example)
    private _serialized = [vehicle player, "Basic"] call FUNC(serializeLoadout);
    (end)

Returns:
    Serialized loadout <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_loadoutName", "", [""]]
];

if !assert(!isNull _vehicle) exitWith {};

private _loadout = [
    _loadoutName,
    getBackpackCargo _vehicle,
    getWeaponCargo _vehicle,
    getMagazineCargo _vehicle,
    getItemCargo _vehicle
];

_loadout;
