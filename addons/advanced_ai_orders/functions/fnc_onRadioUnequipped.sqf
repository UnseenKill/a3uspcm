#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_onRadioUnequipped

Description:
    CBA event handler for "CBA_EVENT_AAIO_RADIO_UNEQUIPPED" event.

Parameters:
    0: _unit - Unit that unequipped the radio <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onRadioUnequipped),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

INFO_1("Player %1 unequipped AAIO radio.",str name _unit);

if !(isNil { _unit getVariable QGVAR(commsMenuItemId) }) then {
    private _menuItemId = _unit getVariable QGVAR(commsMenuItemId);
    _unit setVariable[QGVAR(commsMenuItemId), nil];
    
    INFO_2("Removing AAIO comms menu for player %1 (item ID: %2).",str name _unit,_menuItemId);
    [_unit, _menuItemId] call BIS_fnc_removeCommMenuItem;
};

nil;
