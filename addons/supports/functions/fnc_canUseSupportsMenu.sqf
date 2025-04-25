#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_canUseSupportsMenu

Description:
    Callback function to check if the supports menu can be opened.

Parameters:
    0: _vehicle - Target <OBJECT>
    1: _player - Caller <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle",objNull,[objNull]],
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if (_player isEqualTo theBoss) exitWith { true };
if (isNull GVAR(moduleSupportProvider)) exitWith { false };

GVAR(moduleSupportProvider) in synchronizedObjects _player;
