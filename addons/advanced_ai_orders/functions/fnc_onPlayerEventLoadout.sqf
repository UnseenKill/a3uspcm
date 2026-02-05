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

if !(_hasRadio) exitWith {
    INFO_1("Player %1 unequipped AAIO radio.",str name _unit);

    if !(isNil { _unit getVariable QGVAR(commsMenuItemId) }) then {
        private _menuItemId = _unit getVariable QGVAR(commsMenuItemId);
        _unit setVariable[QGVAR(commsMenuItemId), nil];
        
        INFO_2("Removing AAIO comms menu for player %1 (item ID: %2).",str name _unit,_menuItemId);
        [_unit, _menuItemId] call BIS_fnc_removeCommMenuItem;
    };
};

private _notify = diag_tickTime > (_unit getVariable[QGVAR(nextEquipNotification), 0]);
_unit setVariable[QGVAR(nextEquipNotification), diag_tickTime + 15];

INFO_1("Player %1 equipped AAIO radio.",str name _unit);
private _menuItemId = if (_notify) then {
    [_unit, QGVAR(CommunicationMenu)] call BIS_fnc_addCommMenuItem;
} else {
    [_unit, QGVAR(CommunicationMenu), nil, nil, ""] call BIS_fnc_addCommMenuItem;
};

_unit setVariable[QGVAR(commsMenuItemId), _menuItemId];

nil;
