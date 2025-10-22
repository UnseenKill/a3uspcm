#include "..\script_component.hpp"
#include "\x\A3A\addons\hals\Addons\store\dialog\idcs.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_halsStoreDialogAdjust

Description:
    Adjusts HALs store dialog to be more user-friendly

Parameters:
    0: _display - Display object of store dialog <DISPLAY>

Optional:

Example:
    (begin example)
    [] call A3USPCM_fixes_fnc_halsStoreDialogAdjust;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(halsStoreDialogAdjust),_this);

disableSerialization;

params[
    ["_display", displayNull, [displayNull]]
];

if !assert(!isNull _display) exitWith {};

uiNamespace setVariable[QGVAR(halsStoreDisplay), _display];
uiNamespace setVariable[QGVAR(halsStoreAutoUpdateAmount), false];

// On "sell" click, allow for amount auto update
_display displayCtrl IDC_BUTTON_BUY ctrlAddEventHandler["ButtonClick", {
    TRACE_1(QFUNC(halsStoreDialogAdjust_ButtonClick),_this);

    private _display = uiNamespace getVariable[QGVAR(halsStoreDisplay), displayNull];
    if !assert(!isNull _display) exitWith {};

    if (cbChecked(_display displayCtrl(IDC_CHECKBOX + 3))) then {
        uiNamespace setVariable[QGVAR(halsStoreAutoUpdateAmount), true];
    };
}];

// If item was just sold, update the amount in the edit box to the next selected item automatically
_display displayCtrl IDC_LISTBOX ctrlAddEventHandler["LBSelChanged", {
    params["_control", "_index"];

    private _display = uiNamespace getVariable[QGVAR(halsStoreDisplay), displayNull];
    if !assert(!isNull _display) exitWith {};

    if (cbChecked(_display displayCtrl(IDC_CHECKBOX + 3))) then {
        if (uiNamespace getVariable[QGVAR(halsStoreAutoUpdateAmount), false]) then {
            TRACE_2(QFUNC(halsStoreDialogAdjust_LBSelChanged),_control,_index);
            [_display, _control, _index] call FUNC(halsStoreDialogUpdateAmount);
        };
    };

    uiNamespace setVariable[QGVAR(halsStoreAutoUpdateAmount), nil];
}];

// If item was double-clicked, set the amount in the edit box when selling
_display displayCtrl IDC_LISTBOX ctrlAddEventHandler["LBDblClick", {
    params["_control", "_index"];

    private _display = uiNamespace getVariable[QGVAR(halsStoreDisplay), displayNull];
    if !assert(!isNull _display) exitWith {};

    if (cbChecked(_display displayCtrl(IDC_CHECKBOX + 3))) then {
        [_display, _control, _index] call FUNC(halsStoreDialogUpdateAmount);
    };
}];

nil;
