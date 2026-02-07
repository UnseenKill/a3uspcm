#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilGetCenter

Description:
    Get center of positions.

Parameters:
    0: _positions - Array of positions <ARRAY>

Optional:

Example:
    (begin example)
    [
        [[1234,5678,0],[4321,8765,0]], // Array of positions
    ] call A3USPCM_fnc_utilGetCenter;
    // --> [2777.5, 7211.5, 0]
    (end example)

Returns:
    <ARRAY> Center of positions

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(utilGetCenter),_this);

if !assert(params[
    ["_positions", nil, [[]]]
]) exitWith {[0,0,0]};

private _center = _positions select 0;
_positions apply { _center = _center vectorAdd _x vectorMultiply 0.5 };
_center;
