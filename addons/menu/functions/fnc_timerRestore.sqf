#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerRestore

Description:
    Restore timers from save data

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(timerRestore),_this);

INFO("Restoring timers...");

[QGVAR(Timers)] call A3A_fnc_getStatVariable;

if isNil QGVAR(Timers) then {
    INFO("No saved timers found, initializing empty array");
    GVAR(Timers) = [false, false];
} else {
    INFO("Loading saved timers");

    if (GVAR(Timers) isEqualType []) then {
        GVAR(Timers) = GVAR(Timers) apply {
            if (_x isEqualType []) then {
                ASSUME_VAR_TYPE(_x,[]);
                createHashMapFromArray _x;
            } else {
                _x;
            };
        };
    } else {
        WARNING("Invalid timers data type, initializing with empty array");
        TRACE_1("invalid value",GVAR(Timers));

        GVAR(Timers) = [false, false];
    };
};

TRACE_1("loaded",GVAR(Timers));

GVAR(Timers) apply {
    if (_x isEqualType createHashMap) then {
        [_x] call FUNC(timerStart);
    };
};

nil;
