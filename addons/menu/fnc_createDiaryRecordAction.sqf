#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Menu_fnc_createDiaryRecordAction

Description:
    Create cheat menu diary record action using addon config

Parameters:
    0: _config - Config for diary record action <CONFIG>

Optional:

Example:
    (begin example)
    [_config] call A3USPCM_Menu_fnc_createDiaryRecordAction;
    (end)

Returns:
    Diary record action structured text <STRING>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_config", configNull, [configNull]]
];

if !assert(!isNull _config) exitWith { "" };

private _key = configName _config;

GVAR(DiaryActions) set[_key, createHashMapFromArray[
    ["action", [] call compile([_config >> "action", "STRING"] call CBA_fnc_getConfigEntry)],
    ["params", if !isText(_config >> "params") then[{[]}, {[[_config >> "params", "STRING"] call CBA_fnc_getConfigEntry]}]],
    ["config", _config]
]];

private _action = format["<%1 expression='[%2] call %3'>%4</%1>", 
    ["execute","executeClose"] select ([_config >> "closeDiary", "NUMBER", 0] call CBA_fnc_getConfigEntry),
    str _key, QFUNC(diaryExecuteAction), [_config >> "caption", "STRING"] call CBA_fnc_getConfigEntry];

if !isText(_config >> "text") exitWith { _action };

format["%1 - %2", _action, [_config >> "text", "STRING"] call CBA_fnc_getConfigEntry];
