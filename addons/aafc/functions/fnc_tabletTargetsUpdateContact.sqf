#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsUpdateContact

Description:
    Update contact in contacts list.

Parameters:
    0: _targetKey - Contacts key to update <STRING>

Optional:
    1: _lnbSort - Whether to sort list after updating contact
        (default: true) <BOOL>
    2: _mayRecurse - Whether the function may call FUNC(addContact) to add 
        contact if it doesn't exist (default: true) <BOOL>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsUpdateContact),_this);

if !assert(params[
    ["_targetKey", nil, [""]]
]) exitWith {};

private _lnbSort = param[1, true, [true]];
private _mayRecurse = param[2, true, [true]];

private _display = uiNamespace getVariable QGVAR(display);
private _tabHost = _display getVariable QGVAR(tabs) get IDC_TABHOST_TARGETS;
private _control = _tabHost get "ctlContacts";

private _contact = GVAR(contacts) get _targetKey;
if !assert(!isNil "_contact") exitWith {};

private _index = ([0, (lnbSize _control select 0) - 1] call FUNCMAIN(utilRange)) findIf {
    _control lnbData[_x, 0] isEqualTo _targetKey;
};

if (_index isEqualTo -1) exitWith {
    if !(_mayRecurse) throw "WTF";
    [_targetKey, _lnbSort] call FUNC(tabletTargetsAddContact);
};

private _unit = _contact get "unit";
private _data = [
    parseNumber !(_contact get "alive"),
    getText(configOf _unit >> "displayName")
];

_control lnbSetPicture[[_index, 0], getText(configOf _unit >> "picture")];
_control lnbSetData[[_index, 1], _data joinString ","];

private _color = switch true do {
    case !(_contact get "alive"): {[0.5, 0.5, 0.5, 1]};
    case ((side _unit) isEqualTo west): {[0, 0.3, 0.6, 1]};
    case ((side _unit) isEqualTo east): {[0.5, 0, 0, 1]};
    case ((side _unit) isEqualTo independent): {[0, 0.5, 0, 1] };
    case ((side _unit) isEqualTo civilian): {[0.4, 0, 0.5, 1]};
    default {[1, 0, 1, 1]};
};

_control lnbSetColor[[_index, 0], _color];
_control lnbSetColor[[_index, 1], _color];

if (_lnbSort) then {
    [_control, 1] lnbSortBy["DATA"];
};

nil;
