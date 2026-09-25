#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_applyCustomProperties

Description:
    Apply user-defined properties from "Properties" class of the config.

Parameters:
    0: _control - control to apply properties to <CONTROL>
    1: _config - properties class from the config <CONFIG>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyCustomProperties),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_config", nil, [configNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};
if !assert(!isNull _config) exitWith {};

configProperties[_config >> "Properties"] apply {
    private _property = configName _x;
    private _value = switch true do {
        case isText(_x): { getText _x };
        case isNumber(_x): { getNumber _x };
        case isArray(_x): { getArray _x };
        default { nil };
    };

    if (isNil "_value") then {
        WARNING_3("%1(%2): failed to determine type for property ""%3""",QFUNC(applyCustomProperties),configName _config,_property);
    } else {
        if !(isNil { _control getVariable _property }) then {
            WARNING_3("%1(%2): property ""%3"" already exists on control",QFUNC(applyCustomProperties),configName _config,_property);
        } else {
            TRACE_2(QFUNC(applyCustomProperties),_property,_value);
            _control setVariable[_property, _value];
        };
    };
};

nil;
