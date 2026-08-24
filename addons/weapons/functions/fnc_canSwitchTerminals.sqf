#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_weapons_fnc_canSwitchTerminals

Description:
    ACE interaction condition handler if switch between MoSens/UAV terminal can happen.

Parameters:
    0: _player - Player object <OBJECT>

Optional:

Example:

Returns:
    Condition result <BOOL>

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith { false };
if !assert(!isNull _player) exitWith { false };

private _slotItem = _player getSlotItemName 612;

if (_slotItem isEqualTo "") exitWith { false };

private _terminals = _player getVariable QGVAR(terminalSwitchConfig);

if (isNil "_terminals") then {
    private _config = configFile >> QPREFIX >> QADDON >> "SwitchTerminals";
    
    _terminals = configProperties[_config] apply {
        [configName _x, getText _x];
    };

    TRACE_1(QFUNC(canSwitchTerminals),_terminals);

    _player setVariable[QGVAR(terminalSwitchConfig), _terminals];
};

private _index = _terminals findIf {
    _x params["_itemClass"];
    _slotItem isKindOf[_itemClass, configFile >> "CfgWeapons"];
};

if (_index isEqualTo -1) exitWith { false };

_terminals select _index params["_itemClass","_switchable"];

if (_switchable in items _player) exitWith { true };

items _player findIf {
    _x isKindOf[_switchable, configFile >> "CfgWeapons"];
} != -1;
