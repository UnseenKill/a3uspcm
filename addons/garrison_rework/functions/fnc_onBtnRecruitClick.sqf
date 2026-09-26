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

switch true do {
    case (GVAR(confirmRecruitment) == 1): {
        private _control = _controls get "RecruitList";
        private _garrisonInfo = _control getVariable QGVAR(garrisonInfo);

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

TRACE_1(QFUNC(onBtnRecruitClick),_continue);

nil;
