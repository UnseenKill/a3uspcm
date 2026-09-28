#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onBroadcastDelta

Description:
    CBA_EVENT_UPDATE_DELTA event handler

Parameters:
    0: _delta - New unit count delta of selected location <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onBroadcastDelta),_this);

if !assert(params[
    ["_delta", nil, [0]]
]) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _control = _controls get "BtnRecruit";

_control ctrlEnable(_delta != 0);

nil;
