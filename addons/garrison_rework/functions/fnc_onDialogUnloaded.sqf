#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onDialogUnloaded

Description:
    CBA_EVENT_DIALOG_UNLOADED event handler

Parameters:
    0: _display - Dialog parent display <DISPLAY>
    1: _exitCode - Dialog exit code <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onDialogUnloaded),_this);

if !assert(params[
    ["_display", nil, [displayNull]],
    ["_exitCode", nil, [0]]
]) exitWith {};
if !assert(!isNull _display) exitWith {};

_display getVariable QGVAR(eventHandlers) apply {
    TRACE_1(QFUNC(onDialogUnloaded),_x);
    _x call CBA_fnc_removeEventHandler;
};

uiNamespace setVariable[QGVAR(display), nil];

nil;
