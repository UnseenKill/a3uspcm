#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_ui_builder_fnc_applyInheritableProperty

Description:
    Apply property from config or inherit from parent

Parameters:
    0: _control - The control to apply the property to <CONTROL>
    1: _config - Config class to retrieve the property from <CONFIG>
    2: _propertyName - Name of the property to apply <STRING>
    3: _propertyGVAR - Global variable associated with the property <STRING>
    4: _defaultValue - Default value to use if the property is not found <ANY>

Optional:
    5: _canParse - if value is string, it should be parsed <BOOL>
        (default: true)
    6: _treatScalarAsPair - convert scalar values to pairs if applicable <BOOL>
        (default: false)

Example:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyInheritableProperty),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_config", nil, [configNull]],
    ["_propertyName", nil, [""]],
    ["_propertyGVAR", nil, [""]],
    ["_defaultValue", nil]
]) exitWith {};
if !assert(!isNull _control) exitWith {};
if !assert(!isNull _config) exitWith {};

private _canParse = param[5, true, [true]];
private _treatScalarAsPair = param[6, false, [true]];
private _value = switch true do {
    case (!_canParse && { isText(_config >> _propertyName) }): { getText(_config >> _propertyName) };
    case (!_canParse && { isNumber(_config >> _propertyName) }): { getNumber(_config >> _propertyName) };
    case (!_canParse && { isArray(_config >> _propertyName) }): { getArray(_config >> _propertyName) };
    case isNumber(_config >> _propertyName);
    case isText(_config >> _propertyName);
    case isArray(_config >> _propertyName): {
        [_control, _propertyName, isArray(_config >> _propertyName), _config] call FUNC(parseControlProperty);
    };
    private _parent = ctrlParentControlsGroup _control;
    case (!(isNull _parent) && { !isNil { _parent getVariable _propertyGVAR } }): {
        _parent getVariable _propertyGVAR;
    };
    default { nil };
};

if (isNil "_value" && isNil "_defaultValue") exitWith {
    TRACE_1(QFUNC(applyInheritableProperty),_propertyName);
};

_value = RETDEF(_value,RETNIL(_defaultValue));

if (_treatScalarAsPair && !(_value isEqualType [])) then {
    _value = [_value, _value];
};

if ((!isNil "_defaultValue") && { !(_value isEqualType _defaultValue) }) then {
    WARNING_4("property ""%1"" of ""%2"" is not of expected type: got=%3; wanted=%4",_propertyName,configName _config,typeName _value,typeName _defaultValue);
};

TRACE_2(QFUNC(applyInheritableProperty),_propertyName,_value);

_control setVariable[_propertyGVAR, _value];

nil;
