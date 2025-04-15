#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilCenterCamera

Description:
    Center the Zeus camera on the specified position and target.

Parameters:
    0: _camera - camera object <OBJECT>
    1: _position - new position of camera <ARRAY>
    2: _target - new target of camera <ARRAY,OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(utilCenterCamera),_this);

_this spawn {
    if !assert(params[
        ["_camera",objNull,[objNull]],
        ["_position",nil,[[]]],
        ["_target",nil,[[],objNull]]
    ]) exitWith {};

    if !assert(!isNull _camera) exitWith {};

    _camera setPos [(_position select 0) - 20, (_position select 1) - 20, 30];
    _camera camSetTarget _target;
    _camera camSetRelPos [20, 20, 15];
    _camera cameraEffect ["internal", "back"];
    _camera camCommit 0.5;

    waitUntil { camCommitted _camera };

    _camera camSetTarget objNull;
    _camera camCommit 0;

    nil;
};

nil;
