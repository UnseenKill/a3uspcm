#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_canUseRemoteTraderMenu

Description:
    Determines if the remote trader menu can be used.

Parameters:
    0: _object - Remote trading terminal object <OBJECT>
    1: _player - Player using the remote trader menu <OBJECT>

Optional:
    2: _arguments - Optional handler arguments <ANY>

Returns:
    <BOOL> True if the remote trader menu can be used, false otherwise.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
//TRACE_1(QFUNC(canUseRemoteTraderMenu),_this);

if !assert(params[
    ["_object", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if (isNil "traderX") exitWith { false };

true;
