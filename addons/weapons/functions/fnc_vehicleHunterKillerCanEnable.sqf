#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleHunterKillerCanEnable

Description:
    This function checks if the vehicle hunter killer can be enabled.

Parameters:
    0: _vehicle - Vehicle to test H/K for <OBJECT>
    1: _player - Player invoking the check <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if (objectParent _player isNotEqualTo _vehicle) exitWith { false };
if (_player isNotEqualTo commander _vehicle) exitWith { false };

(_vehicle getVariable[QGVAR(hunterkiller), false] isEqualTo false) && 
!(isNumber(configOf _vehicle >> "ace_hunterkiller")) &&
!(isArray(configOf _vehicle >> "ace_hunterkiller"));
