#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onBroadcastDelta

Description:
    CBA_EVENT_UPDATE_DELTA event handler

Parameters:
    0: _delta - New unit count delta of selected location <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onBroadcastDelta),_this);

if !assert(params[
    ["_delta", nil, [0]]
]) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _control = _controls get "RecruitingWarning";
private _warnings = [];

if (GVAR(hrBuffer) isEqualTo 0 && { _delta > (server getVariable "hr") }) then {
    _warnings pushBack LLSTRING(Dialog_RecruitingWarning_HRDepleted);
};

if (GVAR(hrBuffer) isNotEqualTo 0 && { _delta + GVAR(hrBuffer) > (server getVariable "hr") }) then {
    _warnings pushBack format[LLSTRING(Dialog_RecruitingWarning_HRBufferExceeded), GVAR(hrBuffer)];
};

if (server getVariable "resourcesFIA" < -(_display getVariable QGVAR(priceTag))) then {
    _warnings pushBack LLSTRING(Dialog_RecruitingWarning_InsufficientMoneyz);
};

if (_warnings isEqualTo []) then {
    _control ctrlSetTooltip "";
    _control ctrlSetFade 1;
} else {
    _control ctrlSetTooltip(_warnings joinString "\n");
    _control ctrlSetFade 0;
};

_control ctrlCommit 0.25;

_control = _controls get "BtnRecruit";
_control ctrlEnable(_delta != 0 && _warnings isEqualTo []);

nil;
