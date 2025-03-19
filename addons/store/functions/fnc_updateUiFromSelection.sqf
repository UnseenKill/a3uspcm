#include "..\script_component.hpp"
#include "..\RscDefine.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_store_fnc_updateUiFromSelection

Description:
    Update UI elements based on selected item in sell dialog

Parameters:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
private _display = uiNamespace getVariable[QGVAR(menuDisplay), displayNull];
if !assert(!isNull _display) exitWith {};

private _list = _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_LISTCONTAINERCONTENT;
private _items = _list getVariable[QGVAR(items), []];
private _index = lbCurSel _list;

TRACE_1(QFUNC(updateUiFromSelection),_index);

try {
    if (_index < 0) then { throw false };

    private _itemIndex = _list lnbData[_index, 0];
    private _data = _items select parseNumber _itemIndex;

    if (_data get "price" isEqualTo false) then { throw false };

    private _price = (_data get "price") * HALs_store_sellFactor;
    private _amount = parseNumber ctrlText(_display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_EDITAMOUNT);

    if (_amount > 0 && _amount <= (_data get "count")) then {
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTTOTALSALE ctrlSetText format["%1 %2", round(_price * _amount), A3A_faction_civ get "currencySymbol"];
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_BTNSELL ctrlEnable true;
    } else {
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTTOTALSALE ctrlSetText "-";
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_BTNSELL ctrlEnable false;
    };

    if !(isNil QGVAR(allowAmountAutoUpdate)) then {
        GVAR(allowAmountAutoUpdate) = nil;
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_EDITAMOUNT ctrlSetText str(_data get "count");
    };

    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_FRAMEITEMINFO ctrlSetText getText((_data get "config") >> (_data get "class") >> "displayName");
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTITEMCOUNT ctrlSetText str(_data get "count");
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTITEMPRICE ctrlSetText format["%1 %2", round _price, A3A_faction_civ get "currencySymbol"];

    if (_data get "type" isEqualTo "weapon") then {
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEMWEAPON ctrlSetText getText((_data get "config") >> (_data get "class") >> "picture");
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEMSQUARE ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
    } else {
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEMSQUARE ctrlSetText getText((_data get "config") >> (_data get "class") >> "picture");
        _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEMWEAPON ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
    };
} catch {
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTITEMCOUNT ctrlSetText "";
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTITEMPRICE ctrlSetText "";
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_TEXTTOTALSALE ctrlSetText "";
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_FRAMEITEMINFO ctrlSetText "";
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEMSQUARE ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEMWEAPON ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
    _display displayCtrl IDC_RSCA3USPCMSTORESELLDIALOG_BTNSELL ctrlEnable false;
};

nil;
