#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerStop

Description:
    Stop running timer

Parameters:
    0: _timer - Timer "object" <HASHMAP>

Optional:

Example:
    (begin example)
    [timer1] call A3USPCM_menu_fnc_timerStop;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_timer",nil,[createHashMap]]
];

if !assert(!isNil "_timer") exitWith {};

private _handle = _timer get "handle";

if (_handle isNotEqualTo false) then {
    if !(scriptDone _handle) then {
        terminate _handle;
    };

    _timer set ["handle", false];
};

nil;
