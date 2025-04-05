#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleWeaponGetAddWeaponChildren

Description:
    Callback for ACE3 self-interaction menu children

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player using the self-interaction <OBJECT>

Optional:

Example:

Returns:
    Array of child menu items <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};

assignedVehicleRole _player params["_type","_path"];

if !assert(_type isEqualTo "turret") exitWith {};

private _list = parseSimpleArray GVAR(vehicleWeaponsAdditionalClasses);
private _turretWeapons = _vehicle weaponsTurret _path;

if !(_list isEqualType []) exitWith {
    ERROR_2("%1(): vehicles classes list could not be parsed from %2",QFUNC(vehicleWeaponGetAddWeaponChildren),GVAR(vehicleWeaponsAdditionalClasses));
};

private _config = [_vehicle, _path] call CBA_fnc_getTurret;

getArray(_config >> "weapons") apply {
    _list pushBackUnique _x;
};

_list = _list select {
    !(_x in _turretWeapons) && isClass(configFile >> "CfgWeapons" >> _x);
} apply {
    [getText(configFile >> "CfgWeapons" >> _x >> "displayName"), _x];
};

_list sort true;

//TRACE_2(QFUNC(vehicleWeaponGetAddWeaponChildren),_list,_turretWeapons);

_list apply {
    _x params["_displayName","_className"];

    [
        [
            format["%1_%2", QUOTE(ADDON), _className],
            _displayName,
            "",
            { [{ call FUNC(vehicleWeaponAdd) }, _this] call CBA_fnc_execNextFrame },
            { true }
        ] call ace_interact_menu_fnc_createAction,
        [],
        [_vehicle, _className, _path]
    ]
};
