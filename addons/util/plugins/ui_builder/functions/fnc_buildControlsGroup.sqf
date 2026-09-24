#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_buildControlsGroup

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

// Create foundation control
private _controlsGroup = [_config, _display, _parent, "RscControlsGroup"] call FUNC(createControlCommon);
if !assert(!isNull _controlsGroup) exitWith { controlNull };

// Keep track of child controls
_controlsGroup setVariable[QUIBVAR(controls), createHashMap];

// Inherit/apply spacing/padding from config or parent control
[_controlsGroup] call FUNC(applyInheritableProperties);

// If background color property present, create RscText background
if (isArray(_config >> "colorBackground")) then {
    private _colorBackground = [_controlsGroup, "colorBackground", true] call FUNC(parseControlProperty);
    _colorBackground = [_colorBackground] call FUNC(parseColor);

    private _dimensions = _controlsGroup getVariable QGVAR(dimensions);
    private _background = _display ctrlCreate["RscText", [] call FUNC(getNextIDC), _controlsGroup];
    _background ctrlSetBackgroundColor _colorBackground;
    _background ctrlSetPosition(_dimensions vectorMultiply[0, 0, 1, 1]);
    _background ctrlCommit 0;

    _controlsGroup getVariable QUIBVAR(controls) set["#background", _background];
};

// Create additional control group for children if there's to be padding
private _parentControlsGroup = _controlsGroup;
private _padding = _controlsGroup getVariable QGVAR(padding);

if (_padding isNotEqualTo [0,0,0,0]) then {
    private _createClass = _controlsGroup getVariable QUIBVAR(createClass);
    private _control = _display ctrlCreate[_createClass, [] call FUNC(getNextIDC), _controlsGroup];
    private _dimensions = +(_controlsGroup getVariable QGVAR(dimensions));

    _dimensions = _dimensions vectorMultiply[0, 0, 1, 1];
    _dimensions = _dimensions vectorAdd(_padding vectorMultiply[1, 1, -2, -2]);

    _control ctrlSetPosition _dimensions;
    _control ctrlCommit 0;

    _control setVariable[QUIBVAR(createClass), _createClass];
    _control setVariable[QGVAR(dimensions), _dimensions];
    _control setVariable[QGVAR(font), _controlsGroup getVariable QGVAR(font)];
    _control setVariable[QGVAR(fontSize), _controlsGroup getVariable QGVAR(fontSize)];
    _control setVariable[QGVAR(padding), _controlsGroup getVariable QGVAR(padding)];
    _control setVariable[QGVAR(spacing), _controlsGroup getVariable QGVAR(spacing)];
    _controlsGroup getVariable QUIBVAR(controls) set["#container", _control];

    _parentControlsGroup = _control;
};

// Recursively create child controls
"true" configClasses(_config >> "Controls")
#ifdef __A3_DEBUG__
select { getNumber(_x >> "__ignore") isEqualTo 0 }
#endif
apply {
    private _subConfig = _x;
    private _control = [_subConfig, _display, _parentControlsGroup] call FUNC(buildControl);

    if !(isNull _control) then {
        _controlsGroup getVariable QUIBVAR(controls) set[configName _subConfig, _control];
    };
};

// Top level controls group gets a copy of elements hashmap variable
if (isNull _parent) then {
    _controlsGroup setVariable[QUIBVAR(controls), +(uiNamespace getVariable GVAR(buildUUID))];
    _controlsGroup setVariable[QUIBVAR(idcMap), createHashMapFromArray(allControls _controlsGroup select {
        ctrlIDC _x >= 0;
    } apply {
        [ctrlIDC _x, _x];
    })];
};

_controlsGroup;
