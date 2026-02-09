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

if !assert(params[
    ["_vehicle", nil, ["", objNull]]
]) exitWith { AA_TYPE_UNKNOWN };
if ((_vehicle isEqualType objNull) && { !assert(!isNull _vehicle) }) exitWith { AA_TYPE_UNKNOWN };

if (_vehicle isEqualType objNull) then {
    _vehicle = typeOf _vehicle;
};

if (getNumber(configFile >> "CfgVehicles" >> _vehicle >> "radarType") isNotEqualTo 2) then {
    WARNING_1("Vehicle %1 does not have radarType 2, assuming it's not an AA vehicle",_vehicle);
    AA_TYPE_UNKNOWN;
};

switch true do {
    // Mk49 Spartan, Mk-29 ESSM,
    case ((["SAM_System_01_base_F", "SAM_System_02_base_F"] findIf { _vehicle isKindOf _x }) != -1): { AA_TYPE_SRSAM };
    // Patriot, S-400
    case ((["SAM_System_03_base_F", "SAM_System_04_base_F"] findIf { _vehicle isKindOf _x }) != -1): { AA_TYPE_LRSAM };
    // AN/MPQ-105, Cronos
    case ((["Radar_System_01_base_F", "Radar_System_02_base_F"] findIf { _vehicle isKindOf _x }) != -1): { AA_TYPE_RADAR };
    // Praetorian 1C, JCA ADS-2 Skynex
    case (_vehicle isKindOf "StaticMGWeapon"): { AA_TYPE_CIWS };
    // RAM-1500 AA, Shilka and the likes
    case (_vehicle isKindOf "Car");
    case (_vehicle isKindOf "Tank"): { AA_TYPE_SPAA };
    default { AA_TYPE_UNKNOWN };
};
