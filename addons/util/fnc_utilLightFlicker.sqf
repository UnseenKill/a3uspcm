#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilLightFlicker

Description:
    Flicker light on or off

Parameters:
    0: _light - Lamp to switch <OBJECT>
    1: _duration - Effect duration in milliseconds <NUMBER>

Optional:
    2: _finalState - Final state of the light ("ON","OFF","AUTO"), default "AUTO" <STRING>

Example:
    (begin example)
    [light1, 0.5, "OFF"] call A3USPCM_fnc_utilLightFlicker;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
_this spawn {
    params[
        ["_light", objNull, [objNull]],
        ["_duration", 0, [0]],
        ["_finalState", "AUTO", [""]]
    ];

    private _state = 0;
    private _end = diag_tickTime + _duration;

    while { (!isNull _light) && (diag_tickTime <= _end) } do {
        _light switchLight(["OFF","ON"] select _state);
        _state = [1, 0] select _state;
        uiSleep((random 100) / 1000);
    };

    _light switchLight _finalState;
};

nil;
