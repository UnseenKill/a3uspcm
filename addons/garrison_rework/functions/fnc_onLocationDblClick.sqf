#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onLocationDblClick

Description:
    CBA_EVENT_DIALOG_LOCATION_DBLCLICK event handler

Parameters:
    0: _control - the control that was double-clicked <CONTROL>
    1: _index - row index double-clicked <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onLocationDblClick),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_index", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _entries = _control getVariable[QGVAR(entries), []];
private _entry = _entries select _index;

TRACE_1(QFUNC(onLocationDblClick),_entry);

// Offset to account for AGM dialog blocking one third of the map
mapAnimAdd[0.5, 0.1, _entry get "position" vectorAdd[0, -400]];
mapAnimCommit;

nil;
