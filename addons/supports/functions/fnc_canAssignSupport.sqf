#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_canAssignSupport

Description:
    Callback function to check if the assign support role can be used.

Parameters:
    0: _vehicle - Target <OBJECT>
    1: _player - Caller <OBJECT>
    2: _supportType - Support type <STRING>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_supportType", "", [""]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if !GVAR(requireSupportBuildings) exitWith { true };
if (GVAR(requireSupportBuildings) && !(_supportType in GVAR(supportBuildings))) exitWith { false };
if (GVAR(requireSpecialists) && !(GVAR(supportSpecialists) getOrDefault[_supportType, false])) exitWith { false };

if (_vehicle getVariable[QGVAR(supportType), false] isNotEqualTo false) exitWith { false };

private _check = switch true do {
    case(_vehicle isKindOf "Air"): { true };
    case(crew _vehicle isEqualTo []): { _vehicle isKindOf "StaticWeapon" };
    default {
        private _group = group(crew _vehicle select 0);

        if !(_group in hcAllGroups theBoss) then { breakWith false };
        _group getVariable[QGVAR(supportType), false] isEqualTo false;
    };
};

if (!_check) exitWith { false };

private _requiredTypes = createHashMapFromArray SUPPORT_TYPES_MAP;

(_requiredTypes getOrDefault[_supportType, ""]) in getArray(configOf _vehicle >> "availableForSupportTypes");
