#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepGetTargets

Description:
    Get targets in front of the vehicle for meep meep to interact with

Parameters:
    0: _target - The vehicle from which the targets are being detected <OBJECT>
    1: _player - The player interacting with the vehicle <OBJECT>

Optional:

Returns:
    <ARRAY> An array of units in front of the vehicle

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepGetTargets),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};
if !assert(!isNull _player) exitWith {};

private _direction = vectorDir _target;
private _position = getPos _target;
private _radius = 50;
private _cone = 45;

private _bisDir = atan(_direction # 0 / _direction # 1);
if (_direction # 1 < 0) then { _bisDir = _bisDir + 180 };

(_player nearObjects["CAManBase", _radius] - (crew _target)) select {
    (alive _x) && {
        // Anybody directly around the vehicle
        (_x distance _target < 10) ||
        // Anybody in front of the vehicle further away
        { [_position, _bisDir, 2 * _cone, getPosWorld _x] call BIS_fnc_inAngleSector }
    }
} apply {
    private _relativeDirection = [(_target getDir _x) - (getDir _target)] call FUNCMAIN(utilNormalizeDirection);
    private _sector = switch true do {
        case (_relativeDirection <= 90): { "front_right" };
        case (_relativeDirection <= 180): { "rear_right" };
        case (_relativeDirection <= 270): { "rear_left" };
        default { "front_left" };
    };
    [_x, _sector, _relativeDirection]
};
