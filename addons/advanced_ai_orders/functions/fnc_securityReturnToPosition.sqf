#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_securityReturnToPosition

Description:
    If unit didn't assume position or was moved from it, make them return to it.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(securityReturnToPosition),_this);

#define MAX_RETURN_DISTANCE 500

private _units = switch true do {
    // Because of "CursorOnGroupMember" condition
    case (groupSelectedUnits player isEqualTo []): {
        [cursorTarget]
    };
    default {
        [player] call FUNC(getGroupSelection);
    };
};

_units select {
    !isNull _x && { !isNil { _x getVariable QGVAR(securityPosition) } }
} apply {
    _x getVariable QGVAR(securityPosition) params["_position", "_direction"];

    if (_x distance _position > MAX_RETURN_DISTANCE) then {
        _x groupRadio "SentSupportNotAvailable";
        _x groupChat format[LLSTRING(OrdersSecurity_Hint_ResumeTooFar), [_x distance _position, 5] call FUNCMAIN(utilCutNumber)];
        continue;
    };

    [player, _x, _position, _direction] spawn FUNC(assumePosition);
};

nil;
