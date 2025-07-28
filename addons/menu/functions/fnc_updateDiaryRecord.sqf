#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_updateDiaryRecord

Description:
    Update cheat menu diary record using addon config

Parameters:
    0: _player - Player for which to create record <OBJECT>
    1: _record - Diary record <OBJECT>
    2: _config - Diary entry config <CONFIG>

Optional:

Example:

Returns:
    Input diary record object

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_player", objNull, [objNull]],
    ["_record", diaryRecordNull, [diaryRecordNull]],
    ["_config", configNull, [configNull]]
];

//TRACE_3(QFUNC(updateDiaryRecord),_player,_record,_config);

if !assert(!isNull _record) exitWith { diaryRecordNull };
if !assert(!isNull _config) exitWith { diaryRecordNull };

private _lines = [];

_lines pushBack format["<font size='20'>%1</font>", [_config >> "caption", "STRING", "N/A"] call CBA_fnc_getConfigEntry];
_lines pushBack format["<font size='10'>%1</font>", [_config >> "text", "STRING", "N/A"] call CBA_fnc_getConfigEntry];
_lines pushBack "";

"true" configClasses _config apply {
    private _condition = [_x >> "condition", "STRING", "true"] call CBA_fnc_getConfigEntry;
    private _value = [_x, player] call compile _condition;

    if !(_value isEqualType false) then {
        WARNING_2("Bad condition return for %1 (%2)",configName _x,RETNIL(_value));
        continue;
    };

    if (_value) then {
        _lines pushBack format["&#160;&#160;&#160;&#160;%1", [_x] call FUNC(createDiaryRecordAction)];
    };

    if (getNumber(_x >> "separator") isEqualTo 1) then {
        _lines pushBack "<font size='8'>&#160;</font>";
    };
};

if isText(_config >> "updateCallback") then {
    private _callback = compile format["_this call %1", getText(_config >> "updateCallback")];
    _lines = [player, _record, _config, _lines] call _callback;
};

_player setDiaryRecordText[[MENU_SUBJECT_ID, _record], [
    [_config >> "caption", "STRING", "N/A"] call CBA_fnc_getConfigEntry,
    _lines joinString '<br />',
    [_config >> "image", "STRING", ""] call CBA_fnc_getConfigEntry
]];

_record;
