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
TRACE_1(QFUNC(tabletTargetsFocus),_this);

if !assert(params[
    ["_tabFocused", nil, [createHashMap]]
]) exitWith {};

if (_tabFocused get "idc" isNotEqualTo IDC_TABHOST_TARGETS) exitWith {};

private["_ctlMap"];
private _display = uiNamespace getVariable QGVAR(display);

if !(isNull(_tabFocused get "ctlMap")) then {
    _ctlMap = _tabFocused get "ctlMap";
} else {
    INFO("Setting up map control for targets tab");

    _ctlMap = _display ctrlCreate[QGVAR(RscMapControl), IDC_TARGETS_CTL_MAP];
    private _mapPos = _tabFocused get "mapPosition";
    private _mapSize = _tabFocused get "mapSize";
    _ctlMap ctrlSetPosition[_mapPos select 0, _mapPos select 1, _mapSize select 0, _mapSize select 1];
    _ctlMap ctrlSetBackgroundColor [0,1,0,1];
    _ctlMap ctrlCommit 0;
    _ctlMap ctrlMapSetPosition [];

    _tabFocused set["ctlMap", _ctlMap];
};

_ctlMap ctrlShow true;
_ctlMap ctrlEnable true;
_ctlMap ctrlMapAnimAdd[1, 0.25, player];
ctrlMapAnimCommit _ctlMap;

nil;
