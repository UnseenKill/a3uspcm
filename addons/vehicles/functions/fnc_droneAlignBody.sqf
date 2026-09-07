#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_droneAlignBody

Description:
    Align the body of a drone to turret direction

Parameters:
    0: _vehicle - the drone vehicle to align <OBJECT>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(droneAlignBody),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

[_vehicle, [0]] call ace_aircraft_fnc_droneGetTurretTargetPos params["_target"];

private _position = getPos _vehicle;
private _direction = _position getDir _target;

//systemChat format["Aligning drone body for vehicle: %1 --> %2°", _vehicle, _direction];

_vehicle setDir _direction;

nil;
