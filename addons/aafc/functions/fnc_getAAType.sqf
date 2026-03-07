#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_getAAType

Description:
    Determine what kind of AA system a vehicle is, if any.

Parameters:
    0: _vehicle - The vehicle to check <OBJECT,STRING>

Optional:

Returns:
    <STRING> On of `AA_TYPE_*` "constants"

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getAAType),_this);

#define RETURN_TYPE(type) \
    GVAR(vehicleTypeCache) set[_vehicle, type]; \
    type

if !assert(params[
    ["_vehicle", nil, ["", objNull]]
]) exitWith { AA_TYPE_UNKNOWN };
if ((_vehicle isEqualType objNull) && { !assert(!isNull _vehicle) }) exitWith { AA_TYPE_UNKNOWN };

if (_vehicle isEqualType objNull) then {
    _vehicle = typeOf _vehicle;
};

if (_vehicle in GVAR(vehicleTypeCache)) exitWith {
    GVAR(vehicleTypeCache) get _vehicle;
};

private _vehicleConfig = configFile >> "CfgVehicles" >> _vehicle;

if (getNumber(_vehicleConfig >> "radarType") isNotEqualTo 2) exitWith {
    WARNING_1("Vehicle %1 does not have radarType 2, assuming it's not an AA vehicle",_vehicle);
    RETURN_TYPE(AA_TYPE_UNKNOWN);
};

private _extractWeapons = {
    params["_class"];

    flatten(getArray(_class >> "weapons") + ("true" configClasses(_class >> "Turrets") apply {
        [_x] call _extractWeapons;
    })) select { _x isNotEqualTo "FakeWeapon" };
};

private _magazines = [];
private _weaponTypes = createHashMap;

([_vehicleConfig] call _extractWeapons) apply {
    configFile >> "CfgWeapons" >> _x;
} select {
    getText(_x >> "simulation") isEqualTo "Weapon";
} apply {
    _magazines insert[-1, getArray(_x >> "magazines"), true];
    _weaponTypes set[getText(_x >> "nameSound"), true];
};

_weaponTypes = keys _weaponTypes;
TRACE_2(QFUNC(getAAType),_vehicle,_weaponTypes);

// We've established that the vehicle has radarType 2 a couple of lines earlier.
// No weapons, but a radar would suggest the vehicle is a radar.
if (_weaponTypes isEqualTo []) exitWith { RETURN_TYPE(AA_TYPE_RADAR) };

// Some sort of weaponry, but it's movable, so it's likely a SPAAG
if (_vehicle isKindOf "Car" || { _vehicle isKindOf "Tank" }) exitWith { RETURN_TYPE(AA_TYPE_SPAAG) };

// Has no missiles, but some sort of weapon, so it's likely a CIWS
if !("MissileLauncher" in _weaponTypes) exitWith { RETURN_TYPE(AA_TYPE_CIWS) };

// Determine max missile range, then categorize if SRSAM or LRSAM based on that.
private _maxMissileRange = [_magazines, 0, {
    private _range = getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _x >> "ammo") >> "missileLockMaxDistance");
    _accumulator max _range;
}] call CBA_fnc_inject;

[AA_TYPE_SRSAM, AA_TYPE_LRSAM] select(_maxMissileRange > SRSAM_RANGE_THRESHOLD);
