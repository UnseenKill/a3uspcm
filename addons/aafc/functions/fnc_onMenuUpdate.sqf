#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_onMenuUpdate

Description:
    Receive the menu update event

Parameters:
    0: _player - Player for which to create record <OBJECT>
    1: _entry - Diary entry <OBJECT>
    2: _config - Config for diary record <CONFIG>
    3: _lines - Lines for the diary record so far <ARRAY>

Optional:

Example:

Returns:
    Input variable _lines with additional lines

Author:
    goreSplatter
---------------------------------------------------------------------------- */
//TRACE_1(QFUNC(onMenuUpdate),_this);

params[
    ["_player", objNull, [objNull]],
    ["_entry", diaryRecordNull, [diaryRecordNull]],
    ["_config", configNull, [configNull]],
    ["_lines", [], []]
];

if !assert(!isNull _player) exitWith {};
if !assert(!isNull _entry) exitWith {};
if !assert(!isNull _config) exitWith {};

if (GVAR(groups) isEqualTo []) exitWith { _lines };

_lines pushBack "";

GVAR(groups) apply {
    private _text = [_x] call FUNC(getGroupMenuText);
    private _actions = [_x] call FUNC(getGroupMenuActions);

    if (_actions isEqualTo []) then {
        _lines pushBack format["* %1", _text];
    } else {
        _lines pushBack format["* %1 - %2", _text, _actions joinString " / "];
    };
};

_lines;
