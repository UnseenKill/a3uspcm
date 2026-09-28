#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onBtnRecruitClick

Description:
    CBA_EVENT_DIALOG_BTNRECRUIT_CLICK event handler

Parameters:
    0: _control - recruit button control <CONTROL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onBtnRecruitClick),_this);

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

if !canSuspend exitWith { _this spawn FUNC(onBtnRecruitClick) };

private _confirmHeader = nil;
private _confirmMessage = nil;
private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _recruitList = _controls get "RecruitList";

switch true do {
    case (GVAR(confirmRecruitment) == 1): {
        private _garrisonInfo = _recruitList getVariable QGVAR(garrisonInfo);

        if (values _garrisonInfo findIf { (_x get "unitCountOriginal") > (_x get "unitCount") } != -1) then {
            _confirmHeader = LLSTRING(RecruitConfirmation_Header);
            _confirmMessage = LLSTRING(RecruitConfirmation_ConfirmFire);
        };
    };
    case (GVAR(confirmRecruitment) == 2): {
        _confirmHeader = LLSTRING(RecruitConfirmation_Header);
        _confirmMessage = LLSTRING(RecruitConfirmation_ConfirmAll);
    };
};

private _continue = true;

if !(isNil "_confirmHeader") then {
    _confirmHeader = format[_confirmHeader, _controls get "ListLocations" getVariable QGVAR(currentEntry) get "label"];
    _continue = [_confirmMessage, _confirmHeader, localize "str_lib_info_yes", localize "str_lib_info_no", _display, true] call BIS_fnc_guiMessage;
};

if !(_continue) exitWith {};

[CBA_EVENT_TOGGLE_INTERACTION, false] call CBA_fnc_localEvent;
[CBA_EVENT_SHOW_MESSAGE, [LLSTRING(Dialog_Message_WaitOnRecruitment)]] call CBA_fnc_localEvent;

private _entry = _controls get "ListLocations" getVariable QGVAR(currentEntry);
private _struct = [_recruitList] call FUNC(makeRecruitStruct);

[_entry, _struct] spawn {
    params["_entry", "_struct"];
    private _uuid = [] call CBA_fnc_createUUID;

    TRACE_3(QFUNC(onBtnRecruitClick),_uuid,_entry,_struct);

    [_entry get "marker", _struct, _uuid] remoteExec[QFUNC(recruitUnits), 2];

    private _finished = waitUntil[{ !isNil { missionNamespace getVariable _uuid } }, 10];

    if (isNull(uiNamespace getVariable QGVAR(display))) exitWith {
        ERROR("display closed while waiting for recruitment to finish");
    };

    [CBA_EVENT_TOGGLE_INTERACTION, true] call CBA_fnc_localEvent;

    if (isNil "_finished") exitWith {
        [CBA_EVENT_SHOW_MESSAGE, [LLSTRING(Dialog_Message_WaitOnRecruitment_Timeout), true]] call CBA_fnc_localEvent;
    };

    private _return = missionNamespace getVariable _uuid;
    missionNamespace setVariable[_uuid, nil];

    if !(_return isEqualType "") then {
        [CBA_EVENT_SHOW_MESSAGE] call CBA_fnc_localEvent;
        [CBA_EVENT_RELOAD_LOCATION] call CBA_fnc_localEvent;
    } else {
        [CBA_EVENT_SHOW_MESSAGE, _return] call CBA_fnc_localEvent;
        [CBA_EVENT_TOGGLE_INTERACTION, false] call CBA_fnc_localEvent;

        [{
            [CBA_EVENT_SHOW_MESSAGE] call CBA_fnc_localEvent;
            [CBA_EVENT_TOGGLE_INTERACTION, true] call CBA_fnc_localEvent;
            [CBA_EVENT_RELOAD_LOCATION] call CBA_fnc_localEvent;
        }, 10] call CBA_fnc_waitAndExecute;
    };
};

nil;
