#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerStart

Description:
    Start timer thread

Parameters:
    0: _timer - Timer "object" <HASHMAP>

Optional:

Example:
    (begin example)
    [timer1] call A3USPCM_menu_fnc_timerStart;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(timerStart),_this);

params[
    ["_timer",nil,[createHashMap]]
];

if !assert(!isNil "_timer") exitWith {};

private _handle = _timer get "handle";

if (_handle isEqualTo false) then {
    // We could just do `[_timer] call FUNC(timerMonitor);` here, but that 
    // spams the logs with the full spawned code
    _handle = [_timer] spawn {
        call FUNC(timerMonitor);
    };

    _timer set ["handle", _handle];
};

nil;
