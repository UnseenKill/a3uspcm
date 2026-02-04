#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_runRemoteTraderMenu

Description:
    Runs the remote trader menu.

Parameters:
    0: _object - Remote trading terminal object <OBJECT>
    1: _player - Player using the remote trader menu <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(runRemoteTraderMenu),_this);

if !assert(params[
    ["_object", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};
if !assert(!isNull _player) exitWith {};

if !assert(!isNil "traderX") exitWith {};

[traderX] call HALs_store_fnc_openStore;

nil;
