#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onToggleInteraction

Description:
    CBA_EVENT_TOGGLE_INTERACTION event handler

Parameters:
    0: _enable - whether to enable or disable UI interaction <BOOL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onToggleInteraction),_this);

if !assert(params[
    ["_enable", nil, [true]]
]) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);

allControls _rootControl apply {
    if (_enable) then {
        _x ctrlEnable(_x getVariable[QGVAR(enabledState), true]);
        _x setVariable[QGVAR(enabledState), nil];
    } else {
        _x setVariable[QGVAR(enabledState), ctrlEnabled _x];
        _x ctrlEnable false;
    };
};

nil;
