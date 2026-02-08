#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilPadString

Description:
    Pad string left or right with spaces to a certain length.

Parameters:
    0: _string - String to pad <STRING>
    1: _length - Desired length of the string after padding <NUMBER>

Optional:
    2: _left - Whether to pad left (true) or right (default: true) <BOOL>

Example:
    (begin example)
    ["example", 10, true] call A3USPCM_fnc_utilPadString; // Returns "   example"
    ["example", 10, false] call A3USPCM_fnc_utilPadString; // Returns "example   "
    (end example)

Returns:
    <STRING> The padded string

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_string", nil, [""]],
    ["_length", nil, [0]]
]) exitWith {};

private _left = param[2, true, [true]];

while { count _string < _length } do {
    if (_left) then {
        _string = " " + _string;
    } else {
        _string = _string + " ";
    };
};

_string;
