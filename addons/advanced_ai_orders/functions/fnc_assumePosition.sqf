#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_assumePosition

Description:
    Order a unit to assume a position with a certain direction.

Parameters:
    0: _commander - Unit issuing the order <OBJECT>
    1: _unit - Unit to pull security <OBJECT>
    2: _position - Where to move <ARRAY>
    3: _direction - Direction to face <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client/Server, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(assumePosition),_this);

if !assert(canSuspend) exitWith { _this spawn FUNC(assumePosition) };
if !assert(params[
    ["_commander", nil, [objNull]],
    ["_unit", nil, [objNull]],
    ["_position", nil, [[]], 3],
    ["_direction", nil, [0]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

private["_watch","_sphere"];

_watch = _position getPos[100, _direction];
_sphere = "Sign_Sphere100cm_F" createVehicleLocal[0,0,0];
_sphere setPosATL _watch;

if !(isNull _commander) then {
    _commander groupChat format["%1, pull security %2°", name _unit, (5 * floor(_direction / 5)) toFixed 0];
};

if !(isNull objectParent _unit) then {
    INFO_1("Ordering unit to disembark: %1",_unit);
    commandGetOut _unit;
};

INFO_1("Waiting for disembarkment: %1",_unit);
waitUntil { (stopped _unit) || { isNull objectParent _unit } };

if (stopped _unit) exitWith { INFO_1("Unit stopped: %1",_unit) };

INFO_1("Unit disembarked: %1",_unit);

_unit commandMove _position;

INFO_1("Waiting for move completion: %1",_unit);
waitUntil { (stopped _unit) || { moveToCompleted _unit } };

if (stopped _unit) exitWith { INFO_1("Unit stopped: %1",_unit) };

INFO_2("Unit move complete: %1, watch %2",_unit,_watch);
_unit commandWatch _watch;
_unit setFormDir _direction;
_unit setDir _direction;

uiSleep 6;
deleteVehicle _sphere;

nil;
