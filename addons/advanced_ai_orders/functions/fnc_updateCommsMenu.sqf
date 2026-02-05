#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_updateCommsMenu

Description:
    Updates the AAIO comms menu for the player.

Parameters:
    0: _unit - Unit whose comms menu should be updated <OBJECT>

Optional:

Example:
    (begin example)
    [_unit] call FUNC(updateCommsMenu);
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(updateCommsMenu),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};



nil;
