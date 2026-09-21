#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_applyHandlers

Description:
    Apply event handlers to a UI control element from config

Parameters:
    0: _control - Control to which the event handlers will be applied <CONTROL>
    1: _config - Configuration class containing the event handlers <CONFIG>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyHandlers),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_config", nil, [configNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};
if !assert(!isNull _config) exitWith {};

configProperties[_config, QUOTE(isText(_x) && { configName _x regexMatch '^on(?:[A-Z][a-z]+)+$/' })] apply {
    private _handler = getText _x;
    private _match = configName _x regexFind["^on((?:[A-Z][a-z]+)+?)(Event)?$/", 0];
    if !assert(_match isNotEqualTo []) exitWith {};

    _match select 0 params["", "_event", "_trigger"];
    _event = _event select 0;

    if !(isNil "_trigger") then {
        _handler = format["[%1, _this] call CBA_fnc_localEvent", str _handler];
    };

    if ("Built" isEqualTo _event) then {
        _control setVariable[QGVAR(builtCallback), compile _handler];
    } else {
        _control ctrlAddEventHandler[_event, compile _handler];
    };

    TRACE_3(QFUNC(applyHandlers),_x,_event,_handler);
};

nil;
