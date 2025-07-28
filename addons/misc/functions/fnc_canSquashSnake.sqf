#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_canSquashSnake

Description:
    Whether interaction to squash a snake should be shown.

Parameters:
    0: _player - Player <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _player) exitWith { false };

_player nearObjects 4 findIf { (alive _x) && {typeOf _x isEqualTo "Snake_random_F"} } >= 0;
