#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_onRadioEquipped

Description:
    CBA event handler for "CBA_EVENT_AAIO_RADIO_EQUIPPED" event.

Parameters:
    0: _unit - Unit that equipped the radio <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onRadioEquipped),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

private _notify = diag_tickTime > (_unit getVariable[QGVAR(nextEquipNotification), 0]);
_unit setVariable[QGVAR(nextEquipNotification), diag_tickTime + 15];

INFO_1("Player %1 equipped AAIO radio.",str name _unit);
private _menuItemId = if (_notify) then {
    [_unit, QGVAR(CommunicationMenu)] call BIS_fnc_addCommMenuItem;
} else {
    [_unit, QGVAR(CommunicationMenu), nil, nil, ""] call BIS_fnc_addCommMenuItem;
};

_unit setVariable[QGVAR(commsMenuItemId), _menuItemId];
[] call FUNC(updateCommsMenu);

nil;
