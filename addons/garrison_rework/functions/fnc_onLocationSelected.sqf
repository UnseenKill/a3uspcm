#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onLocationSelected

Description:
    CBA_EVENT_DIALOG_LOCATION_SELECTED event handler

Parameters:
    0: _control - The control that triggered the event <CONTROL>
    1: _index - The index of the selected location <SCALAR>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onLocationSelected),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_index", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

// Toggle recruitment panel
private _rootControl = _control getVariable QUIBVAR(root);
private _recruitGroup = _rootControl getVariable QUIBVAR(controls) get "CenterPanel";

allControls _recruitGroup apply { _x ctrlEnable (_index >= 0) };

// Nothing selected, exit early
if (_index < 0) exitWith {};

nil;
