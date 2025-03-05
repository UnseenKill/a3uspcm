#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_deactivateBeacon

Description:
    Deactivates the despawn beacon.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget] call A3USPCM_despawnbeacon_fnc_deactivateBeacon;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(deactivateBeacon),_this);

params[
    ["_beacon", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _beacon) exitWith {};

[_player, "PutDown"] call ace_common_fnc_doGesture;

private _uav = _beacon getVariable[QGVAR(UAV), objNull];

if (isNull _uav) exitWith {};

crew _uav apply { deleteVehicle _x };
deleteVehicle _uav;

_beacon setVariable[QGVAR(UAV), nil];

private _marker = _beacon getVariable[QGVAR(marker), false];
if !(_marker isEqualType false) then {
    deleteMarker _marker;
    _beacon setVariable[QGVAR(marker), nil];
};

nil;
