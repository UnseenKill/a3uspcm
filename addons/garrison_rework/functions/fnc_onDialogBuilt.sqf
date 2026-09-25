#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onDialogBuilt

Description:
    CBA_EVENT_DIALOG_BUILT event handler

Parameters:
    0: _control - dialog root control <CONTROL>
    1: _className - dialog root control class name <STRING>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onDialogBuilt),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_className", nil, [""]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
_display setVariable[QGVAR(rootControl), _control];

private _filters = _display getVariable QGVAR(filters);
private _filtersToChecksMap = createHashMapFromArray[
    [FILTER_AT_CAPACITY, "ChecksHideFull"],
    [FILTER_BASES, "ChecksShowBases"],
    [FILTER_OUTPOSTS, "ChecksShowOutposts"],
    [FILTER_POSTS, "ChecksShowPosts"],
    [FILTER_RESOURCES, "ChecksShowResources"],
    [FILTER_TOWNS, "ChecksShowTowns"]
];

_filtersToChecksMap apply {
    private _filter = _x;
    private _className = _y;
    private _toolboxControl = _control getVariable QUIBVAR(controls) get _className;

    _toolboxControl lbSetCurSel parseNumber(_filter in _filters);
};

[CBA_EVENT_UPDATE_LOCATIONS] call CBA_fnc_localEvent;

nil;
