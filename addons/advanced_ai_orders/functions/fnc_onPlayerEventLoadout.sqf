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
    3: _execute - Whether to execute the loadout change immediately or delay it
        (default: false) <BOOL>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
//TRACE_1(QFUNC(onPlayerEventLoadout),_this);

if !assert(params[
    ["_unit", nil, [objNull]],
    ["_newUnitLoadout", nil, [[]]],
    ["_oldUnitLoadout", nil, [[]]]
]) exitWith {};

if !assert(!isNull _unit) exitWith {};
if (_unit isNotEqualTo player) exitWith {}; // Don't really know, if this is necessary

private _execute = param[3, false, [true]];

// Suppress repeated calls to this function when user dumps his inventory
if !(_execute) exitWith {
    GVAR(fireLoadoutEventAfter) = diag_tickTime + (missionNamespace getVariable[QGVAR(waitAndExecuteDelay), 5]);

    if (isNil QGVAR(fireLoadoutScript)) then {
        GVAR(fireLoadoutScript) = (_this + [true]) spawn {
            waitUntil { diag_tickTime > GVAR(fireLoadoutEventAfter) };
            GVAR(fireLoadoutScript) = nil;

            TRACE_1(QFUNC(onPlayerEventLoadout),_this);
            call FUNC(onPlayerEventLoadout);
        };
    };
};

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
