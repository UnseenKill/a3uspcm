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
    _unit groupChat localize LSTRING(Message_NoWeaponInHand);
};

private _config = configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems";
private _displayName = getText(configFile >> "CfgWeapons" >> _weapon >> "displayName");

if !isClass(_config) exitWith {
    _unit groupChat localize LSTRING(Message_NoMuzzleConfigurable);
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
        _unit groupChat localize LSTRING(Message_NoMuzzleAttached);
    } else {
        switch _weaponType do {
            case 0: { _unit removePrimaryWeaponItem _muzzleDevice };
            case 1: { _unit removeSecondaryWeaponItem _muzzleDevice };
            case 2: { _unit removeHandgunItem _muzzleDevice };
        };

        _unit addItem _muzzleDevice;
        _unit groupChat localize selectRandom[
            LSTRING(Message_MuzzleRemoved0),
            LSTRING(Message_MuzzleRemoved1),
            LSTRING(Message_MuzzleRemoved2),
            LSTRING(Message_MuzzleRemoved3)
        ];
    };
} else {
    if (_muzzleDevice isNotEqualTo "") then {
        _unit groupChat localize LSTRING(Message_MuzzleAlreadyAttached);
    } else {
        private _compatible = configProperties[_config, "getNumber(_x) > 0", true] apply { configName _x };
        private _intersect = items _unit arrayIntersect _compatible;

        if (_intersect isEqualTo []) then {
            _unit groupChat format[localize LSTRING(Message_NoCompatibleSuppressors), _displayName];
        } else {
            _muzzleDevice = _intersect select 0;

            switch _weaponType do {
                case 0: { _unit addPrimaryWeaponItem _muzzleDevice };
                case 1: { _unit addSecondaryWeaponItem _muzzleDevice };
                case 2: { _unit addHandgunItem _muzzleDevice };
            };

            _unit removeItem _muzzleDevice;
            _unit groupChat localize selectRandom[
                LSTRING(Message_MuzzleAttached0),
                LSTRING(Message_MuzzleAttached1),
                LSTRING(Message_MuzzleAttached2),
                LSTRING(Message_MuzzleAttached3)
            ];
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
