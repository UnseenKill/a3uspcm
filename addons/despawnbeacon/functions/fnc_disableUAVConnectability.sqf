#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_disableUAVConnectability

Description:
    Disables UAV connectability for the given UAV.

Parameters:
    0: _uav - UAV object <OBJECT>

Optional:

Example:
    (begin example)
    [_uav] call FUNC(disableUAVConnectability);
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(disableUAVConnectability),_this);

if !assert(params[
    ["_uav", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _uav) exitWith {};

player disableUAVConnectability[_uav, true];

nil;
