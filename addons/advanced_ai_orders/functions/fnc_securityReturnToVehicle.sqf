#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_securityReturnToVehicle

Description:
    Order a unit to return to their vehicle and board it.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(securityReturnToVehicle),_this);


private _units = switch true do {
    // Because of "CursorOnGroupMember" condition
    case (groupSelectedUnits player isEqualTo []): {
        [cursorTarget]
    };
    default {
        [player] call FUNC(getGroupSelection);
    };
};

(_units select {
    !isNull _x && { !isNil { _x getVariable QGVAR(previousVehicle) } }
} apply {
    _x assignAsCargo(_x getVariable QGVAR(previousVehicle));
    _x;
}) orderGetIn true;

nil;
