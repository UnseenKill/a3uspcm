#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_onClientPostInitDSB

Description:
    Post init event handler when DSBs are set up.

Parameters:
    0: _beacon - DSB object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onClientPostInitDSB),_this);

if !assert(params[
    ["_beacon", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _beacon) exitWith {};

[_beacon] call FUNC(addInteractions);

nil;
