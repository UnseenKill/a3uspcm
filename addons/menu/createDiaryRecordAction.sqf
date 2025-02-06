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

format[
    "<execute expression='[] call %1'>%2</execute> - %3",
    [_config >> "action", "STRING", "false"] call CBA_fnc_getConfigEntry,
    [_config >> "caption", "STRING", "false"] call CBA_fnc_getConfigEntry,
    [_config >> "text", "STRING", "false"] call CBA_fnc_getConfigEntry
];
