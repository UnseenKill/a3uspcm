#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerSave

Description:
    Serialize timer data for save game data

Parameters:
    0: _timer - Timer "object" <HASHMAP>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(timerSave),_this);

params[
    ["_timer",nil,[createHashMap]]
];

if (_timer get "handle" isEqualTo false) then {
    GVAR(Timers) set[_timer get "index", false];
} else {
    GVAR(Timers) set[_timer get "index", _timer];
};

nil;
