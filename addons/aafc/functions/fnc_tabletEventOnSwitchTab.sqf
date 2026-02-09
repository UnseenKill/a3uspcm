#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletEventOnSwitchTab

Description:
    CBA_EVENT_AAFC_DIALOG_SWITCHTAB event handler.

Parameters:
    0: _idcTarget - Tab host control IDC <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled (self)

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !(canSuspend) exitWith { _this spawn FUNC(tabletEventOnSwitchTab) };

TRACE_1(QFUNC(tabletEventOnSwitchTab),_this);

#define COMMIT_DELAY 0.25

if !assert(params[
    ["_idcTarget", nil, [0]]
]) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);

if (_display getVariable QGVAR(currentTab) isEqualTo _idcTarget) exitWith {
    WARNING_1("Got tab switch request for %1 which is already active, ignoring.",_idcTarget);
};

if (_display getVariable[QGVAR(tabSwitchLocked), false]) exitWith {
    WARNING("Tab switch locked, ignoring.");
};

_display setVariable[QGVAR(tabSwitchLocked), true];

private["_ctlNewTabHost","_ctlOldTabHost"];
private _oldTab = _display getVariable QGVAR(tabs) get(_display getVariable QGVAR(currentTab));
private _newTab = _display getVariable QGVAR(tabs) get _idcTarget;

if !assert(!isNil "_newTab") exitWith {};

if !(isNil "_oldTab") then {
    _ctlOldTabHost = _oldTab get "tabhost";
    _ctlOldTabHost ctrlEnable false;
    _ctlOldTabHost ctrlSetFade 1;

    (_oldTab get "button") ctrlSetBackgroundColor getArray(configFile >> QGVAR(RscButtonTab) >> "colorBackground");
};

[CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_BEFORE, [RETNIL(_oldTab), _newTab]] call CBA_fnc_localEvent;
[CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE, [_newTab, RETNIL(_oldTab)]] call CBA_fnc_localEvent;

(_newTab get "button") ctrlSetBackgroundColor getArray(configFile >> QGVAR(RscButtonTab) >> "colorBackgroundTabActive");
_ctlNewTabHost = _newTab get "tabhost";
_ctlNewTabHost ctrlSetFade 0;
_ctlNewTabHost ctrlShow true;

if !(isNil "_ctlOldTabHost") then {
    _ctlOldTabHost ctrlCommit COMMIT_DELAY;
};

_ctlNewTabHost ctrlCommit COMMIT_DELAY;
waitUntil { ctrlCommitted _ctlNewTabHost };

if !(isNil "_ctlOldTabHost") then {
    _ctlOldTabHost ctrlShow false;
};

_ctlNewTabHost ctrlEnable true;

_display setVariable[QGVAR(currentTab), _idcTarget];
_display setVariable[QGVAR(tabSwitchLocked), nil];

[CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_AFTER, [_newTab, RETNIL(_oldTab)]] call CBA_fnc_localEvent;
[CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_AFTER, [RETNIL(_oldTab), _newTab]] call CBA_fnc_localEvent;

nil;
