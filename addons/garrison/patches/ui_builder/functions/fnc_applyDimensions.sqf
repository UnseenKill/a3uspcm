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

#define COMPILE_PROPERTY(propertyName) (switch true do { \
    case isNumber(_config >> QUOTE(propertyName)): { getNumber(_config >> propertyName) }; \
    case !assert(isText(_config >> QUOTE(propertyName))): { 0 }; \
    private _property = getText(_config >> QUOTE(propertyName)); \
    case (_property regexMatch "^[0-9]+%$"): { \
        throw "come back later"; \
    }; \
    default { [] call compile _property }; \
})

private _px = COMPILE_PROPERTY(x);
private _py = COMPILE_PROPERTY(y);
private _pw = COMPILE_PROPERTY(w);
private _ph = COMPILE_PROPERTY(h);

_control ctrlSetPosition[_px, _py, _pw, _ph];
