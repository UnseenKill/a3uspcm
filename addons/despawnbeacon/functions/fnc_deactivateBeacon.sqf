#include "..\script_component.hpp"
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
_this spawn {
    TRACE_1(QFUNC(deactivateBeacon),_this);

    params[
        ["_beacon", objNull, [objNull]],
        ["_player", objNull, [objNull]]
    ];

    if !assert(!isNull _beacon) exitWith {};

    private _uav = _beacon getVariable[QGVAR(UAV), objNull];

    if (isNull _uav) exitWith {};

    if !assert(!isNull _player) exitWith {};

    [_player, "PutDown"] call ace_common_fnc_doGesture;
    _beacon setVariable[QGVAR(active), nil];

    TRACE_1(QFUNC(deactivateBeacon_waitState),_beacon);
    waitUntil { _beacon getVariable[QGVAR(ready), false] };
    TRACE_1(QFUNC(deactivateBeacon_cleanupState),_beacon);

    crew _uav apply { deleteVehicle _x };
    deleteVehicle _uav;

    _beacon setVariable[QGVAR(UAV), nil];

    private _marker = _beacon getVariable[QGVAR(marker), false];
    if !(_marker isEqualType false) then {
        deleteMarker _marker;
        _beacon setVariable[QGVAR(marker), nil];
    };
};

nil;
