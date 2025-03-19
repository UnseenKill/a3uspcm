#include "..\script_component.hpp"
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

private _record = _player createDiaryRecord[_subjectId, ["","",""]];

[_player, _record, _config] call FUNC(updateDiaryRecord);
