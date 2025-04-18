#include "..\script_component.hpp"
#include "..\RscDefine.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_onDialogOpen

Description:
    Initialize loadout manager dialog.

Parameters:
    0: _display - Loadout manager dialog <DISPLAY>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onDialogOpen),_this);

params[
    ["_display", displayNull, [displayNull]]
];

if !assert(!isNull _display) exitWith {};

uiNamespace setVariable[QGVAR(menuDisplay), _display];

allControls _display apply {
    _x ctrlEnable false;
};

private["_control"];

// Close button
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNCLOSE;
_control ctrlEnable true;
_control ctrlAddEventHandler["ButtonClick", {
    closeDialog 2;
}];

// Save button
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNSAVE;
_control ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(BtnSave),_this);
    params[["_control",controlNull,[controlNull]]];
    [GVAR(vehicle), player] call FUNC(saveLoadout);
    closeDialog 0;
}];

if ([GVAR(vehicle)] call FUNCMAIN(utilVehicleHasCargo)) then {
    _control ctrlEnable true;
};

// Delete button
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNDELETE;
_control ctrlEnable true;
_control ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(BtnDelete),_this);

    private _display = uiNamespace getVariable QGVAR(menuDisplay);
    private _list = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_LISTLOADOUTS;
    private _index = parseNumber(_list lnbData[lnbCurSelRow _list, 0]);

    private _lo = GVAR(Loadouts) deleteAt _index;
    [QGVAR(Loadouts), GVAR(Loadouts)] call A3A_fnc_setStatVariable;

    systemChat format[localize LSTRING(HintLoadoutDeletedText), _lo select 0];
    _list lnbDeleteRow lnbCurSelRow _list;
}];

// Rename button
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNRENAME;
_control ctrlEnable true;
_control ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(BtnRename),_this);

    private _display = uiNamespace getVariable QGVAR(menuDisplay);
    private _list = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_LISTLOADOUTS;
    private _index = parseNumber(_list lnbData[lnbCurSelRow _list, 0]);

    closeDialog 0;

    [_index] spawn {
        params[["_index",0,[0]]];
        [GVAR(vehicle), player, _index] call FUNC(renameLoadout);

        uiSleep 0.5;
        waitUntil { isNull findDisplay 314555 };
        uiSleep 0.125;

        createDialog QGVAR(Dialog);
    };
}];

// Overwrite button
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNOVERWRITE;
_control ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(BtnOverwrite),_this);

    private _display = uiNamespace getVariable QGVAR(menuDisplay);
    private _list = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_LISTLOADOUTS;
    private _index = parseNumber(_list lnbData[lnbCurSelRow _list, 0]);

    closeDialog 0;
    [GVAR(vehicle), player, _index] call FUNC(overwriteLoadout);
}];

// Apply button
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNAPPLY;
_control ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(BtnApply),_this);

    private _display = uiNamespace getVariable QGVAR(menuDisplay);
    private _list = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_LISTLOADOUTS;
    private _index = parseNumber(_list lnbData[lnbCurSelRow _list, 0]);

    closeDialog 0;
    [GVAR(vehicle), player, GVAR(Loadouts) select _index] call FUNC(restoreLoadout);
}];

// Loadouts list
_control = _display displayCtrl IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_LISTLOADOUTS;
_control ctrlEnable true;
_control ctrlAddEventHandler["LBSelChanged", {
    TRACE_1(QFUNC(LBSelChanged),_this);
    params[["_control",controlNull,[controlNull]],["_index",0,[0]]];

    private _display = uiNamespace getVariable QGVAR(menuDisplay);

    [IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNAPPLY, IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNRENAME, IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNOVERWRITE, IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNDELETE] apply {
        if (_x isNotEqualTo IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNOVERWRITE) then {
            _display displayCtrl _x ctrlEnable (_index >= 0);
        } else {
            _display displayCtrl _x ctrlEnable ((_index >= 0) && ([GVAR(vehicle)] call FUNCMAIN(utilVehicleHasCargo)));
        };
    };
}];

{
    private _index = _control lnbAddRow [_x select 0];
    _control lnbSetData[[_index, 0], str _foreachIndex];
} forEach GVAR(Loadouts);

if (GVAR(Loadouts) isNotEqualTo []) then {
    _control lnbSetCurSelRow 0;
};

nil;
