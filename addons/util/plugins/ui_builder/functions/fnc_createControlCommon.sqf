#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_createControlCommon

Description:
    Create control from config, apply common properties and event handlers

    Called to create both controls groups and individual controls

Parameters:
    0: _config - Config class from which to read UI structure <CONFIG>
    1: _display - Parent display <DISPLAY>
    2: _parent - Parent controls groups <CONTROL>
    3: _defaultClass - Default class to use if none is specified in the config <STRING>

Optional:

Example:

Returns:
    <CONTROL> - created control

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(createControlCommon),_this);

if !assert(params[
    ["_config", nil, [configNull]],
    ["_display", nil, [displayNull]],
    ["_parent", nil, [controlNull]],
    ["_defaultClass", nil, [""]]
]) exitWith {};

// Even though elements are nested in controls groups, don't allow duplicate
// class names across the entire UI structure
private _elementsMap = uiNamespace getVariable GVAR(buildUUID);
if (getNumber(_config >> "ignoreMap") isEqualTo 0 &&
    { !(configName _config in GVAR(ignoreMap)) } &&
    { !assert(!(configName _config in _elementsMap)) })
    throw format["duplicate element class name ""%1""", configName _config];

if (isNumber(_config >> "idcBase")) then {
    INFO_4("%1(%2): setting IDC base from %3 to %4",QFUNC(createControlCommon),configName _config,GVAR(idcBase),getNumber(_config >> "idcBase"));
    GVAR(idcBase) = getNumber(_config >> "idcBase");
};

// Create control
private _idc = if (isNumber(_config >> "idc")) then {
    getNumber(_config >> "idc");
} else {
    [] call FUNC(getNextIDC);
};

private _className = [_config >> "className", "STRING", _defaultClass] call CBA_fnc_getConfigEntry;
private _control = _display ctrlCreate[_className, _idc, _parent];

// Bail out if control creation failed
if !assert(!isNull _control) throw format["failed to create control of class ""%1"" with idc %2", _className, _idc];
_elementsMap set[configName _config, _control];

// Common properties
_control setVariable[QUIBVAR(config), _config];
_control setVariable[QUIBVAR(configName), configName _config];
_control setVariable[QUIBVAR(createClass), _className];

// Control properties
[_control] call FUNC(applyInheritableProperties);

if (isNumber(_config >> "enabled")) then {
    private _enabled = [_config >> "enabled", "NUMBER", 1] call CBA_fnc_getConfigEntry;
    _control ctrlEnable(_enabled != 0);
};

if (isNumber(_config >> "visible")) then {
    private _visible = [_config >> "visible", "NUMBER", 1] call CBA_fnc_getConfigEntry;
    _control ctrlShow(_visible != 0);
};

if (isNumber(_config >> "fade")) then {
    private _fade = [_config >> "fade", "NUMBER", 1] call CBA_fnc_getConfigEntry;
    _control ctrlSetFade _fade;
};

if (isText(_config >> "text")) then {
    private _text = [_config >> "text", "STRING", ""] call CBA_fnc_getConfigEntry;
    _control ctrlSetText _text;
};

if (isText(_config >> "tooltip")) then {
    private _tooltip = [_config >> "tooltip", "STRING", ""] call CBA_fnc_getConfigEntry;
    _control ctrlSetTooltip _tooltip;
};

if (isArray(_config >> "color")) then {
    private _color = [_config >> "color", "ARRAY", [1,1,1,1]] call CBA_fnc_getConfigEntry;
    _control ctrlSetTextColor([_color] call FUNC(parseColor));
};

if (isArray(_config >> "colorBackground")) then {
    private _color = [_config >> "colorBackground", "ARRAY", [0,0,0,1]] call CBA_fnc_getConfigEntry;
    _control ctrlSetBackgroundColor([_color] call FUNC(parseColor));
};

_control ctrlSetFont(_control getVariable QGVAR(font));
if (_control getVariable QGVAR(fontSize) > 0) then {
    _control ctrlSetFontHeight(_control getVariable QGVAR(fontSize));
};

// Apply common properties and event handlers
[_control, _config] call FUNC(applyDimensions);
[_control, _config] call FUNC(applyHandlers);
[_control, _config] call FUNC(applyTypeSpecific);

_control ctrlCommit 0;

if !(isNil { _control getVariable QGVAR(createCallback) }) then {
    private _callback = _control getVariable QGVAR(createCallback);
    _control setVariable[QGVAR(createCallback), nil];

    [_control, configName _config] call _callback;
};

_control;
