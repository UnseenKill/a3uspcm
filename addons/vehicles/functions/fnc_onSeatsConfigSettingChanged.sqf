#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_onSeatsConfigSettingChanged

Description:
    Adopt incoming changes from CBA addon settings to the seats configuration.

Parameters:
    0: _value - Changed config value <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onSeatsConfigSettingChanged),_this);

if !assert(params[
    ["_value", nil, [""]]
]) exitWith {};

GVAR(seatsConfig) = [];

private _array = parseSimpleArray _value;
if (isNil "_array" || { !(_array isEqualType []) }) exitWith {
    ERROR_1("Failed to parse simple array from setting %1",str _value);
};

GVAR(seatsConfig) = _array select {
    if !(_x isEqualType []) then {
        ERROR_1("Invalid entry in seats config array: %1",str _x);
        continueWith false;
    };

    if !assert(_x params[["_vehicleClass", nil, [""]],["_config", nil, [[]]]]) then {
        ERROR_1("Invalid entry in seats config array: %1",str _x);
        continueWith false;
    };

    _config findIf {
        !(
            (_x isEqualType 0) || { _x isEqualType [] }
        ) && {
            ERROR_2("Invalid seat config for vehicle %1: %2",_vehicleClass,str _x);
            true;
        };
    } == -1;
};

nil;
