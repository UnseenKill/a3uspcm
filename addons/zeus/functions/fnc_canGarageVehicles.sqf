#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_canGarageVehicles

Description:
    Check if one of the vehicles in selection can be garaged.

Parameters:
    0: _position - Zeus cursor position (unused) <ARRAY>
    1: _selection - Zeus object selection <ARRAY>

Optional:

Example:

Returns:
    <BOOL> - True if one of the vehicles in selection can be garaged.

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params["",["_vehicles",[],[[]]]];

_vehicles findIf { TEST_CAN_GARAGE(_x) } >= 0;
