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
TRACE_1(QFUNC(tabletTargetsSetup),_this);

if !assert(params[
    ["_display", nil, [displayNull]],
    ["_ctlTabHost", nil, [controlNull]],
    ["_tabHost", nil, [createHashMap]]
]) exitWith {};

if (IDC_TABHOST_TARGETS isNotEqualTo ctrlIDC _ctlTabHost) exitWith {};

private["_control","_mapPosition"];

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
