#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilInterpolateColor

Description:
    Interpolates between two colors based on a value between 0 and 1

Parameters:
    0: _value - Value between 0 and 1 <NUMBER>
    1: _fromColor - RGBA array <ARRAY>
    2: _toColor - RGBA array <ARRAY>

Optional:

Example:
    (begin example)
    [0.5, [1,0,0,1], [0,1,0,1]] call A3USPCM_fnc_utilInterpolateColor;
    (end example)

Returns:
    <ARRAY> RGBA array

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(utilInterpolateColor),_this);

if !assert(params[
    ["_value", nil, [0]],
    ["_fromColor", nil, [[]], 4],
    ["_toColor", nil, [[]], 4]
]) exitWith {[0,0,0,0]};

[
    linearConversion[0, 1, _value, _fromColor select 0, _toColor select 0],
    linearConversion[0, 1, _value, _fromColor select 1, _toColor select 1],
    linearConversion[0, 1, _value, _fromColor select 2, _toColor select 2],
    linearConversion[0, 1, _value, _fromColor select 3, _toColor select 3]
];
