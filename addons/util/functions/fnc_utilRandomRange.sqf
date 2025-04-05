#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilRandomRange

Description:
    Generate a random number between two values

Parameters:
    0: _min - Minimum range <NUMBER>
    1: _max - Maximum range <NUMBER>

Optional:

Example:
    (begin example)
    [5,10] call A3USPCM_fnc_utilRandomRange;
    (end example)

Returns:
    Return description <TYPE>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if !assert(params[["_min",nil,[0]], ["_max",nil,[0]]]) exitWith { 0 };
if !assert(!isNil "_min") exitWith { 0 };
if !assert(!isNil "_max") exitWith { 0 };

if (_max isEqualTo _min) exitWith { _min };
if !assert(_min < _max) exitWith { _min };
_min + round(random(_max - _min));
