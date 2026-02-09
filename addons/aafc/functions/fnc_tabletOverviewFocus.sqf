#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletOverviewFocus

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
TRACE_1(QFUNC(tabletOverviewFocus),_this);

if !assert(params[
    ["_tabFocused", nil, [createHashMap]]
]) exitWith {};

if (_tabFocused get "idc" isNotEqualTo IDC_TABHOST_OVERVIEW) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
private _ctlTabHost = _tabFocused get "ctlGroupsHost";
private["_tabHost","_control","_startX","_startY"];

// Delete what's left from previous call or the placeholder
allControls _ctlTabHost apply { ctrlDelete _x };

ctrlPosition _ctlTabHost params["","","_tw","_th"];
_startX = -16 * UI_GRID_W;

if (GVAR(groups) isEqualTo []) exitWith {
    _control = _display ctrlCreate[QGVAR(RscTextCentered), 0, _ctlTabHost];
    _control ctrlSetPosition[0, 0, _tw, _th];
    _control ctrlSetText "No A/A groups assigned, yet.";
    _control ctrlCommit 0;
};

private _index = -1;
private _groups = GVAR(groups) apply { [groupId _x, _x] };
_groups sort true;
_groups apply {
    private _group = _x select -1;
    private _backgroundColor = [1,1,1,[0.1, 0.25] select (_index mod 2)];

    _startY = -UI_GRID_H - pixelH * 4;

    CBA_TRIGGER(CBA_EVENT_AAFC_UPDATE_GROUP,[_group]);

    INC(_index);
    ADD(_startX,16 * UI_GRID_W + pixelW * 4);

    _control = _display ctrlCreate[QGVAR(RscText), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX, 0, 16 * UI_GRID_W, UI_GRID_H];
    _control ctrlSetText format["%1", groupId _group];
    _control ctrlSetBackgroundColor _backgroundColor;
    _control ctrlCommit 0;

    _tabHost = _display ctrlCreate[QGVAR(RscControlsGroup), 0, _ctlTabHost];
    _tabHost ctrlSetPosition[_startX, UI_GRID_H + pixelH * 4, 16 * UI_GRID_W, _th - UI_GRID_H - pixelH * 4];
    _tabHost ctrlCommit 0;

    _group getVariable QGVAR(vehicles) apply {
        private _color = [damage _x, [1,1,1,1], [1,0,0,1]] call FUNCMAIN(utilInterpolateColor);

        ADD(_startY,UI_GRID_H + pixelH * 4);

        private _combatMode = unitCombatMode _x;

        _control = _display ctrlCreate["RscPictureKeepAspect", 0, _tabHost];
        _control ctrlSetPosition[0, _startY, UI_GRID_W, UI_GRID_H];
        _control ctrlSetTextColor((_combatMode call CBA_fnc_cssColorToDecimal) + [1]);
        _control ctrlSetText getText(configOf _x >> "picture");
        _control ctrlSetTooltip format["%1", _combatMode];
        _control ctrlCommit 0;

        _control = _display ctrlCreate[QGVAR(RscStructuredText), 0, _tabHost];
        _control ctrlSetPosition[UI_GRID_W, _startY, 15 * UI_GRID_W, UI_GRID_H];
        _control ctrlSetStructuredText parseText format["%1 (<t color='%4'>%2%3</t>)", getText(configOf _x >> "displayName"), ((1 - damage _x) * 100) toFixed 0, "%", _color call BIS_fnc_colorRGBtoHTML];
        _control ctrlSetBackgroundColor _backgroundColor;
        _control ctrlCommit 0;
    };
};

CBA_TRIGGER(CBA_EVENT_AAFC_SET_ROE_GLOBAL,[GVAR(globalROE)]);

nil;
