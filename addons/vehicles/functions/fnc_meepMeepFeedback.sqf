#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepFeedback

Description:
    Make either vehicle commander or systemChat feed back messages to player

Parameters:
    0: _target - The vehicle from which the message is originating <OBJECT>
    1: _message - The message to be displayed <STRING>

Optional:
    2: _success - Whether the message is something that's successful <BOOL>
        (default: true)
    3: _speakerOverride - A unit from the player's side speaking <OBJECT>

Returns:
    <BOOL> Always false

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepFeedback),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_message", nil, [""]]
]) exitWith {};

private _success = param[2, true, [true]];
private _speakerOverride = param[3, nil, [objNull]];

if (isNil "_speakerOverride") then {
    _speakerOverride = commander _target;
};

if (isNull _speakerOverride) then {
    systemChat _message;
} else {
    if (_speakerOverride in units _target) then {
        _speakerOverride groupChat _message;
    } else {
        _speakerOverride sideChat _message;
    };
};

false;
