#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onReloadLocation

Description:
    CBA_EVENT_RELOAD_LOCATION event handler

Parameters:

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onReloadLocation),_this);

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _control = _controls get "ListLocations";

private _selection = _control getVariable QGVAR(currentSelection);
_control setVariable[QGVAR(currentSelection), nil];

[CBA_EVENT_DIALOG_LOCATION_SELECTED, [_control, _selection]] call CBA_fnc_localEvent;

nil;
