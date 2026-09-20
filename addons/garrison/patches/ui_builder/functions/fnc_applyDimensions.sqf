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
    private _value = switch true do { \
        case !(QUOTE(propertyName) in _properties): { ["N/A", 0] }; \
        case isNumber(_config >> QUOTE(propertyName)): { ["NUM", getNumber(_config >> QUOTE(propertyName))] }; \
        case !assert(isText(_config >> QUOTE(propertyName))): { ["TXT", 0] }; \
        private _property = getText(_config >> QUOTE(propertyName)); \
        case (_property isEqualTo ""): { ["MT", 0] }; \
        case (_property regexMatch "^[0-9]+%$"): { \
            throw "come back later"; \
        }; \
        default { ["CMP", [] call compile getText(_config >> QUOTE(propertyName))] }; \
    }; \
    TRACE_3(QFUNC(applyDimensions),_control,QUOTE(propertyName),_value); \
    _value select 1; \
})

private _properties = configProperties[_config] apply { configName _x };
private _px = COMPILE_PROPERTY(x);
private _py = COMPILE_PROPERTY(y);
private _pw = COMPILE_PROPERTY(w);
private _ph = COMPILE_PROPERTY(h);

_control ctrlSetPosition[_px, _py, _pw, _ph];
