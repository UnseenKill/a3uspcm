#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_resupplyPilotAnnounce

Description:
    Make pilot announce something.

Parameters:
    0: _unit - Unit piloting the vehicle <OBJECT>
    1: _message - Message to announce <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(resupplyPilotAnnounce),_this);

if !assert(params[
    ["_unit", nil, [objNull]],
    ["_message", nil, [""]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

[_unit, format["[%1] %2", getText(configOf objectParent _unit >> "displayName"), _message]] remoteExecCall["sideChat", side _unit];

nil;
