#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_ui_builder_fnc_buildControlsGroup

Description:
    Create UI recursively from config

Parameters:
    0: _config - Config class from which to read UI structure <CONFIG>
    1: _display - Parent display <DISPLAY>
    2: _parent - Parent controls groups <CONTROL>

Optional:

Example:

Returns:
    <CONTROL>

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(buildControlsGroup),_this);

if !assert(params[
    ["_config", nil, [configNull]],
    ["_display", nil, [displayNull]],
    ["_parent", nil, [controlNull]]
]) exitWith { controlNull };
if !assert(!isNull _config) exitWith { controlNull };
if !assert(!isNull _display) exitWith { controlNull };

if !assert(isClass(_config >> "Controls")) exitWith { controlNull };

private _controlsGroup = [_config, _display, _parent, "RscControlsGroup"] call FUNC(createControlCommon);
if !assert(!isNull _controlsGroup) exitWith { controlNull };

_controlsGroup setVariable[QGVAR(controls), createHashMap];

"true" configClasses(_config >> "Controls") apply {
    private _subConfig = _x;
    private _control = if (isClass(_subConfig >> "Controls")) then {
        [_subConfig, _display, _controlsGroup] call FUNC(buildControlsGroup);
    } else {
        [_subConfig, _display, _controlsGroup] call FUNC(buildControl);
    };

    if !(isNull _control) then {
        _controlsGroup getVariable QGVAR(controls) set[configName _subConfig, _control];
    };
};

// Top level controls group gets a copy of elements hashmap variable
if (isNull _parent) then {
    _controlsGroup setVariable[QGVAR(controls), +(uiNamespace getVariable GVAR(buildUUID))];
};

_controlsGroup;
