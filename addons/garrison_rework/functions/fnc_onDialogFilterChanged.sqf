#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onDialogFilterChanged

Description:
    CBA_EVENT_DIALOG_FILTER_CHANGED event handler

Parameters:
    0: _control - Filter toolbox control <CONTROL>
    1: _selectionIndex - Selected index <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onDialogFilterChanged),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_selectionIndex", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _parent = ctrlParentControlsGroup _control;
private _display = uiNamespace getVariable QGVAR(display);
private _thisFilter = _control getVariable QGVAR(filterType);

if (isNil { _parent getVariable QGVAR(pendingFilters) }) then {
    _parent setVariable[QGVAR(pendingFilters), +(_display getVariable QGVAR(filters))];
};

private _filters = _parent getVariable QGVAR(pendingFilters);
private _before = +_filters;

if (_selectionIndex isEqualTo 0) then {
    _filters = _filters - [_thisFilter];
} else {
    _filters pushBackUnique _thisFilter;
};

TRACE_6("A",_control,_parent,_selectionIndex,_thisFilter,_before,_filters);

_parent setVariable[QGVAR(pendingFilters), _filters];

[_parent] spawn FUNC(applyPendingFilters);

nil;
