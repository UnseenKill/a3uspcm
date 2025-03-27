#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerMonitor

Description:
    Monitor timer

Parameters:
    0: _timer - Timer "object" <HASHMAP>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(timerMonitor),_this);

params[
    ["_timer",nil,[createHashMap]]
];

private _expiration = _timer get "expiration";
private _start = _timer get "start";
private _unit = (dateToNumber[_timer get "year", 1, 1, 0, 1]) - (dateToNumber[_timer get "year", 1, 1, 0, 0]);
private _dateExpired = _start + _unit * _expiration;

//INFO_1("before fix...: %1",_dateExpired toFixed 20);
_dateExpired = dateToNumber numberToDate[_timer get "year",_dateExpired];
//INFO_1("after fix....: %1",_dateExpired toFixed 20);

_timer set["dateExpired",_dateExpired];

INFO_4("%1(%4) starting timer; beginning %2; ending %3",QFUNC(timerMonitor),numberToDate[ARR_2(_timer get "year",_start)],numberToDate[ARR_2(_timer get "year",_dateExpired)],_timer get "uid");

while { true } do {
    private _now = dateToNumber date;

    if (_now >= _dateExpired) then {
        break;
    };

    private _wait = 25;
    TRACE_1(QFUNC(timerStart),_wait);
    sleep _wait; // _Needs_ to be sleep, not uiSleep
};

INFO_2("%1(%2) timer expired",QFUNC(timerMonitor),_timer get "uid");

[_timer] call FUNC(timerStop);

nil;
