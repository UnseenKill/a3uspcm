#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_registerAAGroup

Description:
    Register a group as an AA group and update menu

Parameters:
    0: _group - Group to register <OBJECT>

Optional:

Example:
    (begin example)
    [group player] call A3USPCM_aafc_fnc_registerAAGroup;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(registerAAGroup),_this);

params[
    ["_group", grpNull, [grpNull]]
];

if !assert(!isNull _group) exitWith {};

GVAR(groups) pushBackUnique _group;
GVAR(updateContext) params[
    ["_player", objNull, [objNull]],
    ["_record", diaryRecordNull, [diaryRecordNull]],
    ["_config", configNull, [configNull]]
];

[_player, _record, _config] call EFUNC(menu,updateDiaryRecord);
[_group] call FUNC(initReportHandler);

switch GVAR(defaultInitialMode) do {
    case "FC_DEFAULT_ANGRY": {
        _group setBehaviour "COMBAT";
        _group setCombatMode "RED";
    };
    case "FC_DEFAULT_CALM": {
        _group setBehaviour "SAFE";
        _group setCombatMode "BLUE";
    };
};

leader _group sideChat localize LSTRING(Message_AARegistered);

nil;
