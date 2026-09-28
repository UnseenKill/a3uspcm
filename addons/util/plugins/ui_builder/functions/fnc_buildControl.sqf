#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_buildControl

Description:
    Build single UI control element from config

Parameters:
    0: _config - Config class from which to read UI structure <CONFIG>
    1: _display - Parent display <DISPLAY>
    2: _parent - Parent controls groups <CONTROL>

Optional:
    3: _allowNullParent - Whether to allow a null parent control <BOOL>
        (default: false)

Example:

Returns:
    <CONTROL>

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(buildControl),_this);

if !assert(params[
    ["_config", nil, [configNull]],
    ["_display", nil, [displayNull]],
    ["_parent", nil, [controlNull]]
]) exitWith { controlNull };
if !assert(!isNull _config) exitWith { controlNull };
if !assert(!isNull _display) exitWith { controlNull };

// Delegate if it's gonna be a controls group
private _control = if (isClass(_config >> "Controls")) then {
    [_config, _display, _parent] call FUNC(buildControlsGroup);
} else {
    private _allowNullParent = param[3, false, [true]];

    if !assert(_allowNullParent || { !isNull _parent }) exitWith { controlNull };

    [_config, _display, _parent, "RscText"] call FUNC(createControlCommon);
};

if (isNull _control) exitWith { controlNull };

if !(isNil { _control getVariable QGVAR(builtCallback) }) then {
    private _callback = _control getVariable QGVAR(builtCallback);
    _control setVariable[QGVAR(builtCallback), nil];

    [_control, configName _config] call _callback;
};

_control;
