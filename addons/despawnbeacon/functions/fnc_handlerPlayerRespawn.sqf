#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_handlerPlayerRespawn

Description:
    Adds inventory monitor for UAV terminals and disallowing connections to DSBs.

Parameters:
    0: _player - Player object respawning/initializing <OBJECT>

Optional:
    1: _corpse - Player's corpse object when respawning <OBJECT>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith {};

if !(isPlayer _player) exitWith {};
if !(isNil { _player getVariable QGVAR(ehSlotItemChanged) }) exitWith {};

TRACE_1(QFUNC(handlerPlayerRespawn),_this);

_player setVariable[QGVAR(ehSlotItemChanged), _player addEventHandler["SlotItemChanged", {
    if !assert(params[
        ["_unit", nil, [objNull]],
        ["_name", nil, [""]],
        ["_slot", nil, [0]],
        ["_assigned", nil, [true]]
    ]) exitWith {};

    TRACE_4(QFUNC(handlerPlayerRespawn_SlotItemChanged),_unit,_name,_slot,_assigned);

    if !(_assigned) exitWith {};
    if (_slot isNotEqualTo 612) exitWith {}; // UAV terminal slot

    [] call FUNC(disableUAVConnectabilityAll);
}]];

[] call FUNC(disableUAVConnectabilityAll);

nil;
