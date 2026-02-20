#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepShooUnits

Description:
    Shoo units away from target vehicle

Parameters:
    0: _target - Target vehicle <OBJECT>
    1: _player - Player initiating the action <OBJECT>
    2: _units - Units to be shooed away <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepShooUnits),_this);

#define SHOO_DISTANCE 15
//#define DEBUG_SHOO

if !assert(params[
    ["_target", nil, [objNull]],
    ["_player", nil, [objNull]],
    ["_units", nil, [[]]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};
if !assert(!isNull _player) exitWith {};
if !assert(canSuspend) exitWith {};

#ifdef DEBUG_SHOO
GVAR(lines) = [];
private _objects = [];
private["_object"];
#endif // DEBUG_SHOO

_units apply {
    _x params["_unit","_sector","_relativeDirection"];

    // Relative fuck-off direction from their own pos as seen from vehicle
    private _shooTo = switch _sector do {
        case "rear_left";
        case "front_left": { 240 };
        case "rear_right";
        case "front_right": { 120 };
    };

    private _unitDirection = [_shooTo + getDir _target] call FUNCMAIN(utilNormalizeDirection);
    private _unitPosition = _unit getPos[SHOO_DISTANCE, _unitDirection];

    TRACE_3(QFUNC(meepMeepShooUnits),_unit,_sector,_unitDirection);

#ifdef DEBUG_SHOO
    _object = "Sign_Sphere100cm_F" createVehicleLocal[0,0,0];
    _object setPosATL _unitPosition;
    _objects pushBack _object;
    GVAR(lines) pushBack[_unitPosition, ASLToAGL eyePos _unit, [1,0,0,1], 8];
#endif // DEBUG_SHOO

    if (side _unit isEqualTo side _target) then {
        _unit sideRadio "SentConfirmMove";
    };

    _unit doMove _unitPosition;
};

#ifndef DEBUG_SHOO
_target setVariable[QGVAR(meepMeepActiveUntil), diag_tickTime + 5];
#else
addMissionEventHandler["Draw3D", {
    if (GVAR(lines) isEqualTo []) exitWith {
        diag_log format["%1:%2 is done.", _thisEvent, _thisEventHandler];
        removeMissionEventHandler[_thisEvent, _thisEventHandler];
    };

    GVAR(lines) apply { drawLine3D(_x apply { if (_x isEqualType {}) then [{call _x}, {_x}] }) };
}];

uiSleep 5;
_objects apply { deleteVehicle _x };
GVAR(lines) = [];
#endif // DEBUG_SHOO

nil;
