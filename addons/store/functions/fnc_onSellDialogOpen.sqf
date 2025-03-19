#include "..\script_component.hpp"
#include "..\RscDefine.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_store_fnc_onSellDialogOpen

Description:
    Initialize better selling dialog

Parameters:
    0: _display - Display of dialog <DISPLAY>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
disableSerialization;

TRACE_1(QFUNC(onSellDialogOpen),_this);

params[["_display",displayNull,[displayNull]]];

if !assert(!isNull _display) exitWith {};

uiNamespace setVariable[QGVAR(menuDisplay), _display];

private["_control"];

// Close button

_display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_BTNCLOSE ctrlAddEventHandler["ButtonClick", {
    closeDialog 0;
}];

// Amount input

_control = _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_EDITAMOUNT;
_control ctrlEnable false;
_control ctrlAddEventHandler["KeyUp", {
    [] call FUNC(updateUiFromSelection);
}];

// Sell button

_control = _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_BTNSELL;
_control ctrlEnable false;
_control ctrlAddEventHandler["ButtonClick", {
    /* something */
}];

// Filter list

_control = _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_DROPFILTERSELECT;
"true" configClasses (configFile >> QGVAR(sellDialog) >> "Filters") apply {
    private _class = configName _x;
    private _label = getText(configFile >> QGVAR(sellDialog) >> "Filters" >> _class >> "displayName");
    private _index = _control lbAdd _label;
    _control lbSetData[_index, _class];
};

_control ctrlEnable false;
_control lbSetCurSel 0;
_control ctrlAddEventHandler["LBSelChanged", {
    params[["_control",controlNull,[controlNull]], ["_index",0,[0]]];
    [] call FUNC(updateSellableItemsList);
}];

// Container items list

_control = _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_LISTCONTAINERCONTENT;
_control ctrlEnable false;
_control ctrlSetFontHeight 0.04;
_control lnbAddColumn 0.23;
_control lnbAddColumn 0.27;
_control ctrlAddEventHandler["LBDblClick", {
    /* something */
}];
_control ctrlAddEventHandler["LBSelChanged", {
    params[["_control",controlNull,[controlNull]], ["_index",0,[0]]];
    [] call FUNC(updateUiFromSelection);
}];

// Show unsellable items checkbox

_control = _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_CHECKSHOWUNSELLABLE;
_control ctrlEnable false;
_control ctrlAddEventHandler["CheckedChanged", {
    [] call FUNC(updateSellableItemsList);
}];

// Wait for breakdown

[_display] spawn {
    params[["_display",displayNull,[displayNull]]];

    waitUntil { isNull _display || GVAR(sellContainerReady) };
    TRACE_1("sellContainerReady",GVAR(sellContainerReady));

    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_STATICWAITFORBREAKDOWN ctrlSetText localize LSTRING(AdvSell_DblClickHint);
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_STATICWAITFORBREAKDOWN ctrlSetTextColor [1,1,1,1];

    [true] call FUNC(updateSellableItemsList);
};

nil;
