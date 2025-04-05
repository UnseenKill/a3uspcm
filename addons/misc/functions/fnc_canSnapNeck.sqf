#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_canSnapNeck

Description:
    Menu condition is target can be euthanized

Parameters:
    0: _target - target object <OBJECT>
    1: _player - player object <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_target",objNull,[objNull]],
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _target) exitWith { false };
if !assert(!isNull _player) exitWith { false };

(alive _target && _target getVariable["ACE_isUnconscious",false] && (side _target isNotEqualTo side _player));
