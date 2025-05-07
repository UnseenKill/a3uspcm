#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_squashSnake

Description:
    Function to squash a snake.

Parameters:
    0: _player - Player <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(squashSnake),_this);

params[
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _player) exitWith {};

_player nearObjects 4 select { (alive _x) && { typeOf _x isEqualTo "Snake_random_F" } } apply {
    [
        {
            playSound selectRandom[QEGVAR(assets,Squash0), QEGVAR(assets,Squash1)];
            _this setDamage 1;
        },
        _x,
        ([0, 250] call FUNCMAIN(utilRandomRange)) / 1000
    ] call CBA_fnc_waitAndExecute;
};

nil;
