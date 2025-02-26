#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Menu_fnc_diaryInitialize

Description:
    Initialize cheat menu in player diary

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_Menu_fnc_diaryInitialize;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_3("A3USPCM_fnc_diaryInitialize - initialize for (name=%1;uid=%2;type=%3)",name player,getPlayerUID player,typeOf player);

GVAR(DiarySubjectIndex) = player createDiarySubject[MENU_SUBJECT_ID, localize LSTRING(DiarySubjectTitle)];
GVAR(DiaryEntries) = createHashMap;

private _config = configFile >> QGVAR(Config) >> "Diary";
private _entries = "true" configClasses _config;

// Order is reversed in actual diary
reverse _entries;

_entries apply {
    private _name = configName _x;
    TRACE_2("creating entry from config",_x,_name);

    private _record = [player, MENU_SUBJECT_ID, _x] call FUNC(createDiaryRecord);

    if !isNull _record then {
        GVAR(DiaryEntries) set[_name, _record];

        if isText(_x >> "initCallback") then {
            private _callback = compile format["_this call %1", getText(_x >> "initCallback")];
            [_name, _record] call _callback;
        };
    };
};

nil;
