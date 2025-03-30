#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleWeaponRemove

Description:
    Callback for ACE3 self-interaction menu action

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(vehicleWeaponRemove),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_params", nil, [[]]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};

assignedVehicleRole _player params["_type","_path"];

if !assert(_type isEqualTo "turret") exitWith {};

private _weapon = _vehicle currentWeaponTurret _path;
if !assert(_weapon isNotEqualTo "") exitWith {};

[_vehicle, _weapon, _path] spawn {
    params[
        ["_vehicle", objNull, [objNull]],
        ["_weapon", "", [""]],
        "_path"
    ];
    private _guiCaption = localize LSTRING(VehicleWeaponsSelfActionsRemoveWeaponText);
    private _guiText = format[localize LSTRING(VehicleWeaponsSelfActionsRemoveWeaponConfirm), getText(configFile >> "CfgWeapons" >> _weapon >> "displayName")];

    if !([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) exitWith {};

    TRACE_3(QFUNC(vehicleWeaponRemove),_vehicle,_weapon,_path);

    _vehicle removeWeaponTurret[_weapon, _path];

    private _modded = _vehicle getVariable[QEGVAR(loadout,moddedTurrets), []];
    _modded pushBackUnique _path;
    _vehicle setVariable[QEGVAR(loadout,moddedTurrets), _modded, true];
};

nil;
