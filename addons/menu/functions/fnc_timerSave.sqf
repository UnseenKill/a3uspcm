#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerSave

Description:
    Serialize timer data for save game data

Parameters:
    0: _timer - Timer "object" <HASHMAP>
    1: _index - Index of the timer <NUMBER>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(timerSave),_this);

params[
    ["_timer",nil,[createHashMap]],
    ["_index",nil,[0]]
];

GVAR(Timers) set[_index, _timer];

[QGVAR(Timers), GVAR(Timers) apply {
    if (_x isEqualType false) then {
        _x;
    } else {
        private _data = +_x;
        _data set["handle", false];
        _data;
    };
}] call A3A_fnc_setStatVariable;
