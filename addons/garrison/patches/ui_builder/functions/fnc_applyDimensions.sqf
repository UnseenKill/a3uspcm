#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_ui_builder_fnc_applyDimensions

Description:
    Apply dimensions to a control based on config

Parameters:
    0: _control - Control to apply dimensions to <CONTROL>
    1: _config - Config class containing dimension information <CONFIG>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyDimensions),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_config", nil, [configNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};
if !assert(!isNull _config) exitWith {};

#define COMPILE_PROPERTY(propertyName) ([] call { \
    private _value = [_control, QUOTE(propertyName)] call FUNC(parseControlProperty); \
    _value = RETDEF(_value,0); \
    TRACE_2(QFUNC(applyDimensions),QUOTE(propertyName),_value); \
    _value; \
})

private _px = COMPILE_PROPERTY(x);
private _py = COMPILE_PROPERTY(y);
private _dimensions = [_px, _py, 0, 0];

if ([isNumber(_config >> "w"), isNumber(_config >> "h"), isText(_config >> "w"), isText(_config >> "h")] findIf { _x } != -1) then {
    _dimensions set[2, COMPILE_PROPERTY(w)];
    _dimensions set[3, COMPILE_PROPERTY(h)];
} else {
    private _class = _control getVariable QGVAR(createClass);

    if (CT_CONTROLS_GROUP isNotEqualTo getNumber(configFile >> _class >> "type")) then {
        WARNING_1("no dimensions for non-control group element ""%1"" found.",configName _config);
        _dimensions append[0, 0];
    } else {
        private _parent = ctrlParentControlsGroup _control;

        if (isNull _parent) then {
            _dimensions append[1, 1];
        } else {
            ctrlPosition _parent params["","","_w","_h"];
            _dimensions append[_w, _h];
        };
    };
};

private _padding = _control getVariable QGVAR(padding);

if (_padding isNotEqualTo [0, 0]) then {
    _padding = [_padding select 0, _padding select 1, -2 * (_padding select 0), -2 * (_padding select 1)];
    _dimensions = _dimensions vectorAdd _padding;
};

_control ctrlSetPosition _dimensions;
