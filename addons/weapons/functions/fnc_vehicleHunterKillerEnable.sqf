#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_vehicleHunterKillerEnable

Description:
    This function enables the vehicle hunter killer system.

Parameters:
    0: _vehicle - Vehicle to test H/K for <OBJECT>
    1: _player - Player invoking the check <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(vehicleHunterKillerEnable),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};

_vehicle setVariable["ace_hunterkiller", true, true];
_vehicle setVariable[QGVAR(hunterkiller), true];

nil;
