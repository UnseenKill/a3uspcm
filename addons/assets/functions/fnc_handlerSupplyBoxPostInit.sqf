#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_handlerSupplyBoxPostInit

Description:
    Post init handler for supply boxes to register them with the logistics system

Parameters:
    0: _object - Supply box object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerSupplyBoxPostInit),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

[_object] call A3A_logistics_fnc_addLoadAction;

nil;
