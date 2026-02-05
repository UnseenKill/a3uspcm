#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_onPlayerEventLoadout

Description:
    CBA event handler for "loadout" player event.

Parameters:
    0: _unit - Unit whose loadout changed <OBJECT>
    1: _newUnitLoadout - New unit loadout <ARRAY>
    2: _oldUnitLoadout - Old unit loadout <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onPlayerEventLoadout),_this);

if !assert(params[
    ["_unit", nil, [objNull]],
    ["_newUnitLoadout", nil, [[]]],
    ["_oldUnitLoadout", nil, [[]]]
]) exitWith {};

if !assert(!isNull _unit) exitWith {};
if (_unit isNotEqualTo player) exitWith {};

private _hadRadio = _unit getVariable[QGVAR(lastRadioEquipped), false];
private _hasRadio = QGVAR(ItemRadio) in assignedItems _unit;
private _needsEquipped = missionNamespace getVariable[QGVAR(requireRadioEquipped), true];

// Look for radio stowed in uniform/vest/backpack as well
if (!_hasRadio && { !_needsEquipped }) then {
    _hasRadio = QGVAR(ItemRadio) in items _unit;
};

INFO_3("Player loadout for %1 changed. Has AAIO radio: %2 (previously had: %3)",str name _unit,_hasRadio,_hadRadio);

if (_hadRadio isEqualTo _hasRadio) exitWith {};
_unit setVariable[QGVAR(lastRadioEquipped), _hasRadio];

private _event = [CBA_EVENT_AAIO_RADIO_UNEQUIPPED, CBA_EVENT_AAIO_RADIO_EQUIPPED] select _hasRadio;

[_event, [_unit]] call CBA_fnc_localEvent;

nil;
