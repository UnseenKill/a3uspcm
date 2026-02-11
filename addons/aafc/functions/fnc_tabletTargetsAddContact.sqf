#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsAddContact

Description:
    Add target to contacts list.

Parameters:
    0: _targetKey - Contacts key to add to contacts list <STRING>

Optional:
    1: _lnbSort - Whether to sort list after adding contact
        (default: true) <BOOL>

Returns:
    <NUMBER> Index of added contact in listbox

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsAddContact),_this);

if !assert(params[
    ["_targetKey", nil, [""]]
]) exitWith {};

private _lnbSort = param[1, true, [true]];

private _display = uiNamespace getVariable QGVAR(display);
private _tabHost = _display getVariable QGVAR(tabs) get IDC_TABHOST_TARGETS;
private _control = _tabHost get "ctlContacts";

private _contact = GVAR(contacts) get _targetKey;
if !assert(!isNil "_contact") exitWith {};

private _unit = _contact get "unit";
private _index = _control lnbAddRow["", getText(configOf _unit >> "displayName")];

_control lnbSetData[[_index, 0], _targetKey];
_control lnbSetData[[_index, 1], ""];

[_targetKey, _lnbSort, false] call FUNC(tabletTargetsUpdateContact);

_index;
