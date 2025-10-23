#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_canUseLoadoutMenu

Description:
    Callback for ACE3 interaction menu

Parameters:
    0: _target - Interaction vehicle <OBJECT>
    1: _player - Player interacting w/ vehicle <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget, player] call A3USPCM_loadout_fnc_canUseLoadoutMenu;
    (end example)

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_target", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _target) exitWith { false };
if !assert(!isNull _player) exitWith { false };
if !isNil QGVAR(A3UEUNSVL_seen) exitWith { false };

if (!alive _target || {locked _target >= 2 || {crew _target isNotEqualTo []}}) exitWith { false };
if (getNumber(configOf _target >> "maximumLoad") <= 0) exitWith { false };
if !(GVAR(requireFlagProximity)) exitWith { true };

nearestObjects[_target, ["FlagCarrier"], GVAR(flagLoadoutRadius)] isNotEqualTo [];
