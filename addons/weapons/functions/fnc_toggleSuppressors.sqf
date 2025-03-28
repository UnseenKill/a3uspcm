#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_toggleSuppressors

Description:
    Toggle suppressors on/off for all the player's team members.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_weapons_fnc_toggleSuppressors;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(toggleSuppressors),_this);

params[
    ["_unit",objNull,[objNull]],
    ["_suppressorOn",nil,[true]] // true = suppressors on, false = suppressors off
];

if !assert(!isNull _unit) exitWith {};

// Arma 2.20
// waitUntil { !(isSwitchingWeapon _unit) };

private _weapon = currentWeapon _unit;

if (_weapon isEqualTo "") exitWith {
    _unit groupChat "No weapon in hand";
};

private _config = configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems";
private _displayName = getText(configFile >> "CfgWeapons" >> _weapon >> "displayName");

if !isClass(_config) exitWith {
    systemChat format["%1 has no muzzle config", _displayName];
};

private _weaponInfo = getUnitLoadout _unit select [0, 3];
private _weaponType = _weaponInfo findIf { _x select 0 isEqualTo _weapon };

if (_weaponType isEqualTo -1) exitWith {
    ERROR_1("currentWeapon '%1' not found in unit loadout?!",_weapon);
    _unit groupChat format["%1 not found in loadout?!", _displayName];
};

private _muzzleDevice = _weaponInfo select _weaponType select 1;

TRACE_4(QFUNC(toggleSuppressors),_displayName,_weaponType,_muzzleDevice,_suppressorOn);

if (isNil "_suppressorOn") then {
    _suppressorOn = (_muzzleDevice isEqualTo "");
};

TRACE_1(QFUNC(toggleSuppressors),_suppressorOn);

if !(_suppressorOn) then {
    if (_muzzleDevice isEqualTo "") then {
        _unit groupChat "No muzzle device attached.";
    } else {
        switch _weaponType do {
            case 0: { _unit removePrimaryWeaponItem _muzzleDevice };
            case 1: { _unit removeSecondaryWeaponItem _muzzleDevice };
            case 2: { _unit removeHandgunItem _muzzleDevice };
        };

        _unit addItem _muzzleDevice;
        _unit groupChat "Going loud.";
    };
} else {
    if (_muzzleDevice isNotEqualTo "") then {
        _unit groupChat "Muzzle device already attached.";
    } else {
        private _compatible = configProperties[_config, "getNumber(_x) > 0", true] apply { configName _x };
        private _intersect = items _unit arrayIntersect _compatible;

        if (_intersect isEqualTo []) then {
            _unit groupChat format["No compatible suppressors for %1 in inventory.", _displayName];
        } else {
            _muzzleDevice = _intersect select 0;

            switch _weaponType do {
                case 0: { _unit addPrimaryWeaponItem _muzzleDevice };
                case 1: { _unit addSecondaryWeaponItem _muzzleDevice };
                case 2: { _unit addHandgunItem _muzzleDevice };
            };

            _unit removeItem _muzzleDevice;
            _unit groupChat "Going silent.";
        };
    };
};

if (_unit isEqualTo leader group _unit) then {
    TRACE_1("toggleSuppressors",_unit);
    ((units group _unit) - [_unit]) apply {
        [_x, _suppressorOn] spawn FUNC(toggleSuppressors);
    };
};

nil;
