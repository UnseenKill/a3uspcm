#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsFocus

Description:
    Runs everytime, the overview tab is focused. Triggered by CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE.

Parameters:
    0: _tabFocused - Tab host gaining focus info hash map <HASHMAP>

Optional:
    1: _tabUnfocused - Tab host losing focus info hash map <HASHMAP>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_tabFocused", nil, [createHashMap]]
]) exitWith {};

if (_tabFocused get "idc" isNotEqualTo IDC_TABHOST_TARGETS) exitWith {};

TRACE_1(QFUNC(tabletTargetsFocus),_this);

private["_control"];
private _display = uiNamespace getVariable QGVAR(display);

if !(isNull(_tabFocused get "ctlMap")) then {
    _control = _tabFocused get "ctlMap";
} else {
    _control = [_display, _tabFocused get "mapPosition", _tabFocused get "mapSize" ] call FUNC(tabletTargetsCreateMapControl);
    _tabFocused set["ctlMap", _control];
};

_control ctrlShow true;
_control ctrlEnable true;
_control ctrlMapAnimAdd[1, 0.25, player];
ctrlMapAnimCommit _control;

_control = _tabFocused get "ctlContacts";
lnbClear _control;

if (keys GVAR(contacts) isEqualTo []) exitWith {
    _control lnbAddRow["No contacts reported."];
};

keys GVAR(contacts) apply { [_x, false] call FUNC(tabletTargetsAddContact) };
[_control, 1] lnbSortBy["DATA"];

nil;
