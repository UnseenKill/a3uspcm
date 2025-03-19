#include "..\script_component.hpp"
#include "\x\A3A\addons\hals\Addons\store\dialog\idcs.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_halsStoreDialogUpdateAmount

Description:
    Updates the amount in the edit box to the selected item

Parameters:
    0: _control - Listbox control <CONTROL>
    1: _index - Index of selected item <NUMBER>

Optional:

Example:
    (begin example)
    [_control, _index] call A3USPCM_fixes_fnc_halsStoreDialogUpdateAmount;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(halsStoreDialogUpdateAmount),_this);

params[
    ["_control", controlNull, [controlNull]],
    ["_index", 0, [0]]
];

private _data = _control lbData _index;
TRACE_1(QFUNC(halsStoreDialogUpdateAmount),_data);

// Original code is making this exception, so go ahead and make sure, it's parsable
if (_data isNotEqualTo "") then {
    parseSimpleArray _data params["_class","_amount"];
    private _amountEdit = _display displayCtrl IDC_EDIT;

    TRACE_3(QFUNC(halsStoreDialogAdjust_LBDblClick),_class,_amount,_amountEdit);
    _amountEdit setVariable["amt", _amount];
    ["edit", ["update", []]] call HALs_store_fnc_main;
};

nil;
