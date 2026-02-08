#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilCutNumber

Description:
    Make a number human readable by rounding down to a precision and adding 
    suffixes (k, M, B, T).

Parameters:
    0: _number - number to be formatted <NUMBER>

Optional:
    1: _precision - number of decimal places to round down to
        (default: 10) <NUMBER>
    2: _useSuffixes - whether to use suffixes (k, M, B, T)
        (default: false) <BOOL>
    3: _unit - unit to add after the number (e.g. "m" for meters) <STRING>

Example:
    (begin example)
    [12345.230, nil, true, "m"] call A3USPCM_fnc_utilCutNumber; // --> "12km"
    [217.57, 10] call A3USPCM_fnc_utilCutNumber; // --> "220"
    (end example)

Returns:
    <STRING> Formatted number

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(utilCutNumber),_this);

if !assert(params[
    ["_number", nil, [0]]
]) exitWith {};

private _precision = param[1, 10, [0]];
private _useSuffixes = param[2, false, [true]];
private _unit = param[3, "", [""]];

private _rounded = floor(round(_number / _precision) * _precision);
private _suffix = if (!_useSuffixes || { abs _number < 1000 }) then {""} else {
    private _suffixes = ["", "k", "M", "B", "T"];
    private _suffixIndex = 0;
    private _absNumber = abs _number;
    while { _absNumber >= 1000 && {_suffixIndex < 4} } do {
        _absNumber = _absNumber / 1000;
        INC(_suffixIndex);
    };
    _suffixes select _suffixIndex
};

format ["%1%2%3", _rounded toFixed 0, _suffix, _unit];
