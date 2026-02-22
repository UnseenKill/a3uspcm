#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilNormalizeDirection

Description:
    Normalize a direction to be within 0-360 degrees.

Parameters:
    0: _direction - Direction to normalize <NUMBER>

Optional:

Example:
    (begin example)
    [231283] call A3USPCM_fnc_utilNormalizeDirection; // Returns 123
    (end example)

Returns:
    <NUMBER> Normalized direction

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
//TRACE_1(QFUNCMAIN(utilNormalizeDirection),_this);

if !assert(params[
    ["_direction", nil, [0]]
]) exitWith {0};

while { _direction < 0 } do { _direction = _direction + 360 };
_direction mod 360;
