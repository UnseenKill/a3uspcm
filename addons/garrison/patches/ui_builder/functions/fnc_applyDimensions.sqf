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
private _pw = COMPILE_PROPERTY(w);
private _ph = COMPILE_PROPERTY(h);

_control ctrlSetPosition[_px, _py, _pw, _ph];
