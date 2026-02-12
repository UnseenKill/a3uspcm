#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsSetup

Description:
    Set up targets tab of tablet dialog.

Parameters:
    0: _display - A/A FC UI display <DISPLAY>
    1: _ctlTabHost - Any tab host <CONTROL>
    2: _tabHost - Tab host info hash map <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_display", nil, [displayNull]],
    ["_ctlTabHost", nil, [controlNull]],
    ["_tabHost", nil, [createHashMap]]
]) exitWith {};

if (IDC_TABHOST_TARGETS isNotEqualTo ctrlIDC _ctlTabHost) exitWith {};

TRACE_1(QFUNC(tabletTargetsSetup),_this);

private["_control","_mapPosition"];

if !GVAR(trackContacts) exitWith {
    allControls _ctlTabHost apply {
        if (ctrlIDC _x isNotEqualTo IDC_TARGETS_LBL_DISABLED) then {
            _x ctrlShow false;
            _x ctrlSetPositionW 0;
            _x ctrlSetPositionH 0;
            _x ctrlCommit 0;
        };
    };
};

CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_CONTACT_UPDATE,{call FUNC(tabletTargetsOnContactUpdate)});

_control = _ctlTabHost controlsGroupCtrl IDC_TARGETS_LBL_DISABLED;
ctrlDelete _control;

_control = _ctlTabHost controlsGroupCtrl IDC_TARGETS_BTN_FOCUSMAP;
_control ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(tabletTargetsSetup_focusEH),_this);
    private _display = uiNamespace getVariable QGVAR(display);
    private _tabHost = _display getVariable QGVAR(tabs) get IDC_TABHOST_TARGETS;
    private _control = _tabHost get "ctlMap";
    ctrlSetFocus _control;
}];

_control = _ctlTabHost controlsGroupCtrl IDC_TARGETS_BTN_SHOWAREAS;
_control ctrlAddEventHandler["ButtonClick", {
    if !(isNil QGVAR(showAreas)) exitWith {
        GVAR(showAreas) apply { deleteMarker _x };
        GVAR(showAreas) = nil;
    };

    GVAR(showAreas) = [];
    GVAR(groups) apply {
        _x getVariable QGVAR(vehicles) select {
            (!isNull gunner _x) && { _x call FUNC(canUnitFire) };
        } apply {
            GVAR(showAreas) append ([_x] call FUNC(drawVehicleEffectiveRangesMarkers));
        };
    };
}];

_control = _ctlTabHost controlsGroupCtrl IDC_TARGETS_LNB_CONTACTS;
ctrlPosition _control params["","","_lw","_lh"];
_control lnbAddColumn 0;
_control lnbAddColumn linearConversion[0, _lw, UI_GRID_W * 2, 0, 1];
_control ctrlAddEventHandler["LBDblClick", { call FUNC(tabletTargetsOnContactDblClick) }];
_tabHost set["ctlContacts", _control];

_mapPosition = [0,0];
_control = _ctlTabHost controlsGroupCtrl IDC_TARGETS_CTL_MAP_PROXY;
ctrlPosition _control params["","","_mw","_mh"];

while { (!isNull _control) && { !(_control isEqualType displayNull) } } do {
    ctrlPosition _control params["_px","_py"];
    _mapPosition = _mapPosition vectorAdd[_px, _py];

    if !(isNull ctrlParentControlsGroup _control) then {
        _control = ctrlParentControlsGroup _control;
    } else {
        _control = ctrlParent _control;
    };
};

TRACE_1(QFUNC(tabletTargetsSetup),_mapPosition);
_tabHost set["mapPosition", _mapPosition];
_tabHost set["mapSize", [_mw, _mh]];
_tabHost set["ctlMap", controlNull];

ctrlDelete(_ctlTabHost controlsGroupCtrl IDC_TARGETS_CTL_MAP_PROXY);

nil;
