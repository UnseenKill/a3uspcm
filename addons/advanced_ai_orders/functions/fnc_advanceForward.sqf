#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_advanceForward

Description:
    Advances the selected units forward by a specified distance/reference.

Parameters:
    0: _reference - Distance to travel, position or unit <NUMBER,ARRAY,OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(advanceForward),_this);

if !assert(params[
    ["_reference", nil, [0, objNull, []], 3]
]) exitWith {};
if (_reference isEqualType objNull && { !assert(!isNull _reference) }) exitWith {};

nil;
