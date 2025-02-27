#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilSpreadPoint

Description:
    Spread a point in a radius around its center

Parameters:
    0: _point - Origin Position2D/Position3D <ARRAY>
    1: _radius - Spread radius <NUMBER>

Optional:

Example:
    (begin example)
    [[0,0,0], 5] call A3USPCM_fnc_utilSpreadPoint;
    (end example)

Returns:
    New location <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_point", [0,0,0], [[]]],
    ["_radius", 5, [0]]
];

if (_radius <= 0) exitWith { _point };

private _new = +_point;

_new set[0, (_new select 0) + (random _radius * 2) - _radius];
_new set[1, (_new select 1) + (random _radius * 2) - _radius];

_new;
