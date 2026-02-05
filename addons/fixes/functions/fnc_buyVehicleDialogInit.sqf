#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_buyVehicleDialogInit

Description:
    Modify buy vehicle dialog stuff.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(buyVehicleDialogInit),_this);

waitUntil { !isNil "A3A_fnc_buyVehicleDialog" };

GVAR(A3A_fnc_buyVehicleDialog) = A3A_fnc_buyVehicleDialog;
A3A_fnc_buyVehicleDialog = {
    [CBA_EVENT_CLIENT_BUYVEHICLEDIALOG_BEFORE, _this] call CBA_fnc_localEvent;
    call GVAR(A3A_fnc_buyVehicleDialog);
    [CBA_EVENT_CLIENT_BUYVEHICLEDIALOG_AFTER, _this] call CBA_fnc_localEvent;
};

nil;
