#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_garageVehicles

Description:
    Garage vehicles in Zeus selection.

Parameters:
    0: _position - Zeus cursor position (unused) <ARRAY>
    1: _selection - Zeus object selection <ARRAY>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(garageVehicles),_this);

params["",["_vehicles",[],[[]]]];

_vehicles select { TEST_CAN_GARAGE(_x) } apply {
    TRACE_1(QFUNC(garageVehicles),_x);

    [_x, clientOwner, call HR_GRG_dLock, player] remoteExecCall["HR_GRG_fnc_addVehicle", 2];
};

nil;
