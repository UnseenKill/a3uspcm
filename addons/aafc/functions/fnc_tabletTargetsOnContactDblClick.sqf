#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsOnContactDblClick

Description:
    Double-click handler for contacts list

Parameters:
    0: _control - The control that was double-clicked <CONTROL>
    1: _index - The index of the row that was double-clicked <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsOnContactDblClick),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_index", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _contactKey = _control lnbData[_index, 0];
private _contact = GVAR(contacts) get _contactKey;
if !assert(!isNil "_contact") exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
private _tabHost = _display getVariable QGVAR(tabs) get IDC_TABHOST_TARGETS;
private _control = _tabHost get "ctlMap";

_control ctrlMapAnimAdd[1, 0.75, getPosATL(_contact get "unit")];
ctrlMapAnimCommit _control;

nil;
