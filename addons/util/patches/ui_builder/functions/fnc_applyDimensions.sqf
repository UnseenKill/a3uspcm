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

#define COMPILE_PROPERTY(propertyName,defaultValue) ([] call { \
    private _value = [_control, QUOTE(propertyName)] call FUNC(parseControlProperty); \
    _value = RETDEF(_value,defaultValue); \
    TRACE_2(QFUNC(applyDimensions),QUOTE(propertyName),_value); \
    _value; \
})

private _parent = ctrlParentControlsGroup _control;
private _px = COMPILE_PROPERTY(x,0);
private _py = COMPILE_PROPERTY(y,0);
private _dimensions = [_px, _py, 0, 0];

if (!(isNumber(_config >> "w") || isText(_config >> "w")) || { !(isNumber(_config >> "h") || isText(_config >> "h")) }) then {
    private _class = _control getVariable QGVAR(createClass);

    if (CT_CONTROLS_GROUP isNotEqualTo getNumber(configFile >> _class >> "type")) then {
        WARNING_1("no dimensions for non-control group element ""%1"" found.",configName _config);
    } else {
        if (isNull _parent) then {
            _dimensions set[2, 1];
            _dimensions set[3, 1];
        } else {
            ctrlPosition _parent params["","","_w","_h"];
            _dimensions set[2, _w];
            _dimensions set[3, _h];
        };
    };
};

_dimensions set[2, COMPILE_PROPERTY(w,_dimensions select 2)];
_dimensions set[3, COMPILE_PROPERTY(h,_dimensions select 3)];

private _offsets = [0, 0, 0, 0];

// Spacing: elements only get spacing along edges that don't "hug"
// their parent control.
private _spacing = _control getVariable QGVAR(spacing) vectorMultiply 0.5;

if (_spacing isNotEqualTo [0, 0]) then {
    ctrlPosition _parent params["","","_parentW","_parentH"];

    // Not hugging the left edge
    if ((_dimensions select 0) > 0) then {
        _offsets set[0, _spacing select 0];
    };

    // Not hugging the top edge
    if ((_dimensions select 1) > 0) then {
        _offsets set[1, _spacing select 1];
    };

    // Not hugging the right edge
    if ((_dimensions select 2) < _parentW) then {
        _offsets set[2, -1 * (_spacing select 0)];
    };

    // Not hugging the bottom edge
    if ((_dimensions select 3) < _parentH) then {
        _offsets set[3, -1 * (_spacing select 1)];
    };
};

_dimensions = _dimensions vectorAdd _offsets;

_control ctrlSetPosition _dimensions;
_control setVariable[QGVAR(dimensions), _dimensions];

nil;
