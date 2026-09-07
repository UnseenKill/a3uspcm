#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_switchTerminals

Description:
    Execute terminal switch ACE interaction

Parameters:
    0: _player - Player object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(switchTerminals),_this);

if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

private _slotItem = _player getSlotItemName 612;
private _terminals = _player getVariable QGVAR(terminalSwitchConfig);

if !assert(_slotItem isNotEqualTo "") exitWith {};
if !assert(!isNil "_terminals") exitWith {};

private _index = _terminals findIf {
    _x params["_itemClass"];
    _slotItem isKindOf[_itemClass, configFile >> "CfgWeapons"];
};

_terminals select _index params["","_switchable"];

private _items = items _player;
_index = _items findIf {
    _x isKindOf[_switchable, configFile >> "CfgWeapons"];
};

if !assert(_index isNotEqualTo -1) exitWith {};

_switchable = _items select _index;
_player unassignItem _slotItem;

TRACE_3(QFUNC(switchTerminals),_slotItem,_switchable,_index);

[{
    params["_player", "_from", "_to"];
    _player assignItem _to;

    [[LSTRING(SwitchTerminalsFeedbackText), getText(configFile >> "CfgWeapons" >> _from >> "displayName"), getText(configFile >> "CfgWeapons" >> _to >> "displayName")], 3] call ace_common_fnc_displayTextStructured;
}, [_player, _slotItem, _switchable]] call CBA_fnc_execNextFrame;

nil;
