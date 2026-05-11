#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_handlerBeaconPostInit

Description:
    Post init function for despawn beacon.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerBeaconPostInit),_this);

if !assert(params[
    ["_beacon", nil, [objNull]]
]) exitWith {};

if !assert(!isNull _beacon) exitWith {};

_beacon allowDamage false;
GVAR(Entities) pushBackUnique _beacon;
GVAR(Entities) = GVAR(Entities) - [objNull];

publicVariable QGVAR(Entities);
[CBA_EVENT_DSB_POSTINIT, [_beacon]] call CBA_fnc_globalEvent;

nil;
