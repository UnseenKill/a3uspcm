#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilCursorTargetAction

Description:
    Execute a callback on a cursor target object.

Parameters:
    0: _callbackOnTarget - call this function on the target object <CODE>

Optional:
    1: _callbackArgs - arguments for the callback <ANY>
    2: _callbackNoTarget - call this function when there is no target <CODE>
    2: _messagesNoTarget - show this caption/message combination (locale ids) when there is no target <ARRAY>

Example:
    (begin example)
    // Hide cursor target
    [
        {
            params[["_target", objNull, [objNull]],"_args"];
            _target hideObjectGlobal true;
        },
        [],
        {
            params["_args"];
            hint "No target";
        }
    ] call A3USPCM_fnc_utilCursorTargetAction;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
_this spawn {
    if (visibleMap) exitWith {
        openMap false;
        uiSleep GVAR(cursorTargetActionDelay);
        call FUNCMAIN(utilCursorTargetAction);
    };

    params[
        ["_callbackOnTarget", {}, [{}]],
        "_callbackArgs",
        ["_callbackNoTarget", {}, [{},""]]
    ];

    if isNull(cursorTarget) exitWith {
        if !(_callbackNoTarget isEqualType []) then {
            _callbackArgs call _callbackNoTarget;
        } else {
            (_callbackNoTarget apply { localize _x }) call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };
    };

    if isNil "_callbackArgs" then {
        [cursorTarget] call _callbackOnTarget;
    } else {
        [cursorTarget, _callbackArgs] call _callbackOnTarget;
    };
};

nil;
