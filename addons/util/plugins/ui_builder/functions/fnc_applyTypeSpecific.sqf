#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_applyTypeSpecific

Description:
    Apply type specific properties from config to UI element

Parameters:
    0: _control - UI control to apply properties to <CONTROL>
    1: _config - Configuration containing type specific properties <CONFIG>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyTypeSpecific),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_config", nil, [configNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};
if !assert(!isNull _config) exitWith {};

if (isNil QGVAR(typeSpecific)) then {
    GVAR(typeSpecific) = createHashMap;

    #include "types\CT_LISTBOX.sqf"
    #include "types\CT_LISTNBOX.sqf"
};

private _type = ctrlType _control;

if !(_type in GVAR(typeSpecific)) exitWith {};

GVAR(typeSpecific) get _type apply {
    private _propertyName = _x;
    private _propertyConfig = _config >> _propertyName;

    TRACE_3(QFUNC(applyTypeSpecific),configName _config,_propertyName,_propertyConfig);

    _y params["_condition","_getter","_action"];

    if (_propertyConfig call _condition) then {
        private _value = _propertyConfig call _getter;
        [_control, _value, _config] call _action;
    };
};

nil;
