#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Menu_fnc_createDiaryRecord

Description:
    Create cheat menu diary record using addon config

Parameters:
    0: _player - Player for which to create record <OBJECT>
    1: _subjectId - Diary subject identifier <STRING>
    2: _config - Config for diary record <CONFIG>

Optional:

Example:
    (begin example)
    [player, "diary_subject", _config] call A3USPCM_Menu_fnc_createDiaryRecord;
    (end)

Returns:
    Diary record <OBJECT>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_player", objNull, [objNull]],
    ["_subjectId", "", [""]],
    ["_config", configNull, [configNull]]
];

if !assert(!isNull _player) exitWith { diaryRecordNull };
if !assert(_subjectId isNotEqualTo "") exitWith { diaryRecordNull };
if !assert(!isNull _config) exitWith { diaryRecordNull };

private _lines = [];

_lines pushBack format["<font size='20'>%1</font>", [_config >> "caption", "STRING", "N/A"] call CBA_fnc_getConfigEntry];
_lines pushBack format["<font size='10'>%1</font>", [_config >> "text", "STRING", "N/A"] call CBA_fnc_getConfigEntry];
_lines pushBack "";

"true" configClasses _config apply {
    _lines pushBack format["&#160;&#160;&#160;&#160;%1", [_x] call FUNC(createDiaryRecordAction)];
};

_player createDiaryRecord[_subjectId, [
    [_config >> "caption", "STRING", "N/A"] call CBA_fnc_getConfigEntry,
    _lines joinString '<br />',
    [_config >> "image", "STRING", ""] call CBA_fnc_getConfigEntry
]];
