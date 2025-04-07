#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_wakeupUnconscious

Description:
    Wake player up from unconscious state.

Parameters:
    0: _player - Player object <OBJECT>

Optional:

Example:
    (begin example)
    [player] call A3USPCM_misc_fnc_wakeupUnconscious;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(wakeupUnconscious),_this);

params[
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _player) exitWith {};

private _zeusDisplay = findDisplay 312;

if isNull(_zeusDisplay) then {
    [_player, false] call ace_medical_status_fnc_setUnconsciousState;
} else {
    _zeusDisplay closeDisplay 2;

    [_player] spawn {
        params["_player"];
        uiSleep 0.5;
        [_player, false] call ace_medical_status_fnc_setUnconsciousState;
    };
};

nil;
