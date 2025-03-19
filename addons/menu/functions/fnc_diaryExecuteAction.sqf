#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Menu_fnc_createDiaryRecordAction

Description:
    Execute diary menu action

Parameters:
    0: _name - Action key from QVAR(DiaryActions) hashmap <STRING>

Optional:

Example:
    (begin example)
    ["MakeLootBox"] call A3USPCM_Menu_fnc_diaryExecuteAction;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
_this spawn {
    params[
        ["_name", "", [""]]
    ];

    TRACE_1(QFUNC(diaryExecuteAction),_name);

    if !assert(_name in GVAR(DiaryActions)) exitWith {};

    private _entry = GVAR(DiaryActions) get _name;
    private _action = _entry get "action";
    private _params = _entry get "params";
    private _config = _entry get "config";

    TRACE_3(QFUNC(diaryExecuteAction),_name,_params,_config);

    GVAR(DiaryConfig) = _config;
    _params call _action;
    GVAR(DiaryConfig) = nil;
};

nil;
