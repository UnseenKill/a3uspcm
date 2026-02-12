#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilGetVehicleEffectiveRanges

Description:
    Read vehicle config for effective ranges of sensors, guns & missiles.

Parameters:
    0: _vehicle - Vehicle class name or object <STRING,OBJECT>

Optional:

Returns:
    <HASHMAP> with the following keys:
    sensorsActive: bool - whether the vehicle has active sensors (e.g. radar)
    sensorsMin: number - minimum effective range of sensors (for air targets)
    sensorsMax: number - maximum effective range of sensors (for air targets)
    weaponsGuns: array - [weapon config, weapon display name] of the most effective gun (if any)
    weaponsGunsMin: number - minimum effective range of the most effective gun (if any
    weaponsGunsMax: number - maximum effective range of the most effective gun (if any)
    weaponsMissiles: array - [ammo config, ammo display name] of the most effective
        missile (if any)
    weaponsMissilesMin: number - minimum effective range of the most effective missile (if any)
    weaponsMissilesMax: number - maximum effective range of the most effective missile (if any)

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_vehicle", nil, ["", objNull]]
]) exitWith {};
if ((_vehicle isEqualType objNull) && {!assert(!isNull _vehicle)}) exitWith {};
private _config = if (_vehicle isEqualType objNull) then {
    configOf _vehicle;
} else {
    configFile >> "CfgVehicles" >> _vehicle;
};

if !assert(isClass _config && { !isNull _config }) exitWith {};

private _result = createHashMapFromArray[
    ["sensorsActive", nil],
    ["sensorsMin", 1e+10],
    ["sensorsMax", 0],
    ["weaponsGuns", []],
    ["weaponsGunsMin", 1e+10],
    ["weaponsGunsMax", 0],
    ["weaponsMissiles", []],
    ["weaponsMissilesMin", 1e+10],
    ["weaponsMissilesMax", 0]
];

["ActiveRadarSensorComponent","PassiveRadarSensorComponent"] findIf {
    private _sensorsConfig = _config >> "Components" >> "SensorsManagerComponent" >> "Components" >> _x;
    if !(isClass _sensorsConfig) then { continueWith false };

    _result set["sensorsActive", [false, true] select getNumber(_sensorsConfig >> "allowsMarking")];
    _result set["sensorsMin", getNumber(_sensorsConfig >> "AirTarget" >> "minRange")];
    _result set["sensorsMax", getNumber(_sensorsConfig >> "AirTarget" >> "maxRange")];
    true;
};

("true" configClasses(_config >> "Turrets")) apply {
    getArray(_x >> "weapons") apply {
        private _wpnConfig = configFile >> "CfgWeapons" >> _x;
        if (getNumber(_wpnConfig >> "type") isNotEqualTo 65536) then { continue }; // not hard-mounted

        getArray(_wpnConfig >> "magazines") apply {
            private _magConfig = configFile >> "CfgMagazines" >> _x;
            private _ammoConfig = configFile >> "CfgAmmo" >> getText(_magConfig >> "ammo");

            switch getText(_magConfig >> "nameSound") do {
                case "mgun";
                case "cannon": {
                    private _max = getNumber(_wpnConfig >> "maxRange");

                    if (_max > (_result get "weaponsGunsMax")) then {
                        _result set["weaponsGuns", [_wpnConfig, getText(_wpnConfig >> "displayName")]];
                        _result set["weaponsGunsMax", _max];
                        _result set["weaponsGunsMin", getNumber(_wpnConfig >> "minRange")];
                    };
                };

                case "missiles": {
                    switch getText(_ammoConfig >> "simulation") do {
                        case "shotMissile": {
                            private _max = getNumber(_ammoConfig >> "missileLockMaxDistance");

                            if (_max > (_result get "weaponsMissilesMax")) then {
                                _result set["weaponsMissiles", [_ammoConfig, getText(_ammoConfig >> "displayName")]];
                                _result set["weaponsMissilesMax", _max];
                                _result set["weaponsMissilesMin", getNumber(_ammoConfig >> "missileLockMinDistance")];
                            };
                        };
                        default { WARNING_2("Weird simulation for missile ammo %1: %2",configName _ammoConfig,getText(_ammoConfig >> "simulation")) };
                    };
                };
            };
        };
    };
};

_result;
