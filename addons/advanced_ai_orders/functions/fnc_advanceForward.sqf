#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_advanceForward

Description:
    Advances the selected units forward by a specified distance/reference.

Parameters:
    0: _reference - Distance to travel, position or unit <NUMBER,ARRAY,OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(advanceForward),_this);

if !assert(params[
    ["_player", nil, [objNull]],
    ["_reference", nil, [0, objNull, []], 3]
]) exitWith {};
if (_reference isEqualType objNull && { !assert(!isNull _reference) }) exitWith {};

private _units = [player] call FUNC(getGroupSelection);

if (_units isEqualTo []) exitWith { systemChat "No units selected" };

#ifndef __A3USPCM_PRODUCTION__
private["_objects","_sphere"];
_objects = [];
#endif // __A3USPCM_PRODUCTION__

// Steps:
// 1. Find current selection center

private _center = getPosATL(_units select 0);
_units apply {
    _center = (_center vectorAdd getPosATL _x) vectorMultiply 0.5;
};

#ifndef __A3USPCM_PRODUCTION__
_sphere = "Sign_Sphere100cm_F" createVehicle[0,0,0];
_sphere setPosATL _center;
_objects pushBack _sphere;
#endif // __A3USPCM_PRODUCTION__

private _position = if (_reference isEqualType []) then {
    _reference;
} else {
    private _directionVector = switch true do {
        case (!isNull objectParent _player): {
            vectorDir objectParent _player;
        };
        case (currentWeapon _player isEqualTo ""): {
            [sin getDir _player, cos getDir _player, 0];
        };
        default {
            _player weaponDirection currentWeapon _player;
        };
    };

    TRACE_3(QFUNC(advanceForward),_directionVector,_reference,currentWeapon _player);

    switch true do {
        case (_reference isEqualType 0): {
            _center vectorAdd (_directionVector vectorMultiply _reference);
        };
        case (_reference isEqualType objNull): {
            getPosATL _reference;
        };
        default { nil };
    };
};

if !assert(!isNil "_position") exitWith { ERROR("sumting wong") };

#ifndef __A3USPCM_PRODUCTION__
_sphere = "Sign_Sphere100cm_F" createVehicle[0,0,0];
_sphere setPosATL _position;
_objects pushBack _sphere;
#endif // __A3USPCM_PRODUCTION__

_units apply {
    private _diff = getPosATL _x vectorAdd(_center vectorMultiply -1);
    private _movePos = _position vectorAdd _diff;
    private _watchDir = _center getDir _movePos;

#ifndef __A3USPCM_PRODUCTION__
    _sphere = "Sign_Sphere100cm_F" createVehicle[0,0,0];
    _sphere setPosATL _movePos;
    _sphere setObjectTextureGlobal[0, "#(rgb,8,8,3)color(1,0,0,1)"];
    _objects pushBack _sphere;
#endif // __A3USPCM_PRODUCTION__

    [_player, _x, _movePos, _watchDir] spawn FUNC(assumePosition);
};

#ifndef __A3USPCM_PRODUCTION__
_objects spawn {
    uiSleep 5;
    _this apply { deleteVehicle _x };
};
#endif // __A3USPCM_PRODUCTION__

nil;
