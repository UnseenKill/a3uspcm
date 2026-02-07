#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilParseAdditionalsList

Description:
    Parse user-defined class=price lists into array.

Parameters:
    0: _classesListString - UD classes list <STRING>

Optional:
    1: _configBase - Config path to check for class existence, default "CfgVehicles" <CONFIG>

Returns:
    <ARRAY> Array of arrays [["className", price], ["className2", price2], ...]

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(utilParseAdditionalsList),_this);

if !assert(params[
    ["_classesListString", nil, [""]]
]) exitWith {[]};

private _configBase = param[1, configFile >> "CfgVehicles", [configNull]];
if !assert(!isNull _configBase) exitWith {[]};

((_classesListString splitString ",") apply {
    private _item = trim _x;
    _item splitString "=" params["_className", ["_price", "500"]];

    if !isClass(_configBase >> _className) then {
        WARNING_3("Additionals list: no such %1 class: %2 (from: %3)",configName _configBase,str _className,str _classesListString);
        continueWith[];
    };

    _price = parseNumber _price;
    if !(_price isEqualType 0) then {
        WARNING_3("Additionals list: invalid price for class %1: %2 (from: %3)",_className,str _item,str _classesListString);
        _price = 500;
    };

    [_className, _price];
}) - [[]];
