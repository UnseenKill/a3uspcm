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

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerBeaconPostInit),_this);

params[
    ["_beacon",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith {};

_beacon allowDamage false;
GVAR(Entities) pushBackUnique _beacon;

[_beacon] remoteExec[QFUNC(addInteractions), 0];

nil;
