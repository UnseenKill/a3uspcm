#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_parseControlProperty

Description:
    Convert "dynamic" control property strings into usable values

Parameters:
    0: _control - the control to apply properties to <CONTROL>
    1: _property - the property to parse <STRING>

Optional:
    2: _recurse - allows array properties and parses them recursively <BOOL>
        (default: false)
    3: _config - the config class containing control properties <CONFIG>

Example:

Returns:
    <ANY>

Environment:
    Client/Server/Both, Unscheduled/Scheduled, ...

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(parseControlProperty),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_property", nil, [""]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _recurse = param[2, false, [true]];
private _config = param[3, _control getVariable QGVAR(config), [configNull]];
private _convertString = {
    private _value = _this;
    private _match = _value regexMatch "^-?\d+%$";
    private _dimensions = if (isNull ctrlParentControlsGroup _control) then {
        [0, 0, safeZoneW, safeZoneH, safeZoneX, safeZoneY];
    } else {
        ctrlPosition ctrlParentControlsGroup _control;
    };

    TRACE_3(QFUNC(parseControlProperty),_value,_match,_dimensions);

    switch true do {
        case (_value isEqualTo ""): { 0 };
        case (_value isEqualTo "true"): { true };
        case (_value isEqualTo "false"): { false };
        case (_value regexMatch "^-?\d+%$"): {
            private _number = parseNumber(_value trim["%", 2]);
            switch true do {
                case (_property isEqualTo "h"): {
                    _dimensions params["","","","_height"];
                    (_number * _height / 100);
                };
                case (_property isEqualTo "y"): {
                    _dimensions params["","","","_height",["_offX", 0],["_offY", 0]];
                    _offY + (_number * _height / 100);
                };
                case (_property isEqualTo "w"): {
                    _dimensions params["","","_width"];
                    (_number * _width / 100);
                };
                case (_property isEqualTo "x"): {
                    _dimensions params["","","_width","",["_offX", 0],["_offY", 0]];
                    _offX + (_number * _width / 100);
                };
                default {
                    WARNING_3("Useless percentage property for %1 ignored (_property=%2,_value=%3)",_control,_property,_value);
                    0;
                }
            };
        };
        default { [] call compile _value };
    };
};

if (isNumber(_config >> _property)) exitWith {
    getNumber(_config >> _property);
};

if (isText(_config >> _property)) exitWith {
    getText(_config >> _property) call _convertString;
};

if (_recurse && isArray(_config >> _property)) exitWith {
    private _recursion = {
        if (_x isEqualType 0) then { continueWith _x };
        if (_x isEqualType "") then { continueWith(_x call _convertString) };
        if (_x isEqualType []) then { continueWith(_x apply _recursion) };
    };

    getArray(_config >> _property) apply _recursion;
};

nil;
