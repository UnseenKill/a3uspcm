#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilVehicleHasCargo

Description:
    Determine if a vehicle has cargo

Parameters:
    0: _vehicle - The vehicle in question <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle player] call A3USPCM_fnc_utilVehicleHasCargo;
    (end example)

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith { false };

0 != count(flatten((getBackpackCargo _vehicle) + (getWeaponCargo _vehicle) + (getMagazineCargo _vehicle) + (getItemCargo _vehicle)));
