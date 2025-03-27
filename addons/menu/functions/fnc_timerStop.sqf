#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerStop

Description:
    Stop running timer

Parameters:
    0: _timer - Timer "object" <HASHMAP>

Optional:
    1: _playNoise - Play a noise timer expires <BOOL>

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
    ["_timer",nil,[createHashMap]],
    ["_playNoise",false,[false]]
];

if !assert(!isNil "_timer") exitWith {};

private _handle = _timer get "handle";

if (_handle isNotEqualTo false) then {
    if !(scriptDone _handle) then {
        terminate _handle;
    };

    _timer set ["handle", false];
};

if (_playNoise) then {
    [QEGVAR(assets,AlarmClock)] remoteExec["playSound", 0];

    [
        localize LSTRING(AlarmClockCaption),
        format[localize LSTRING(AlarmClockText), _timer get "_expiration"]
    ] remoteExec["A3A_fnc_customHint", 0];
};

nil;
