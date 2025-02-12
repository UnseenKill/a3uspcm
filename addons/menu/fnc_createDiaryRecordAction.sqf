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

private _action = if !isText(_config >> "params") then {
    format[
        "<execute expression='[] call %1'>%2</execute>",
        [_config >> "action", "STRING"] call CBA_fnc_getConfigEntry,
        [_config >> "caption", "STRING"] call CBA_fnc_getConfigEntry
    ]
} else {
    format[
        "<execute expression='[%1] call %2'>%3</execute>",
        str([_config >> "params", "STRING"] call CBA_fnc_getConfigEntry),
        [_config >> "action", "STRING"] call CBA_fnc_getConfigEntry,
        [_config >> "caption", "STRING"] call CBA_fnc_getConfigEntry
    ]
};

if !isText(_config >> "text") exitWith { _action };

format["%1 - %2", _action, [_config >> "text", "STRING"] call CBA_fnc_getConfigEntry];
