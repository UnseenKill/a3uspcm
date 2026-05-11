#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_handlerUAVPostInit

Description:
    Post init event handler for DSB UAVs.

Parameters:
    0: _uav - UAV object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerUAVPostInit),_this);

if !assert(params[
    ["_uav", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _uav) exitWith {};

[_uav] call FUNC(disableUAVConnectability);

nil;
