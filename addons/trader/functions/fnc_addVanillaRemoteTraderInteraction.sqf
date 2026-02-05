#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_addVanillaRemoteTraderInteraction

Description:
    Adds the vanilla remote trader interaction to remote trading terminal.

Parameters:
    0: _object - Remote trader terminal object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(addVanillaRemoteTraderInteraction),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

if EGVAR(main,AceHaveAddon) exitWith {};

_object addAction[
    LLSTRING(MenuRemoteTrader),
    { call FUNC(runRemoteTraderMenu) },
    nil, 1.5, true, true, "",
    QUOTE([ARR_2(_target,_this)] call FUNC(canUseRemoteTraderMenu)),
    4
];

nil;
