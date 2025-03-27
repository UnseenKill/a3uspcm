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
    _handle = [_timer] spawn {
        params[
            ["_timer",nil,[createHashMap]]
        ];

        private _expiration = _timer get "expiration";
        private _start = _timer get "start";
        private _dateExpired = _start + _expiration;

        while { true } do {
            private _now = dateToNumber date;

            if (_now >= _dateExpired) then {
                break;
            };

            private _wait = (_dateExpired - _now) / 2;

            TRACE_2(QFUNC(timerStart),_wait,_timer);
            sleep _wait; // _Needs_ to be sleep, not uiSleep
        };

        [_timer] call FUNC(timerStop);
    };

    _timer set ["handle", _handle];
};

nil;
