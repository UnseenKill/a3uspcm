#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_revealFOV

Description:
    Reveal enemies in player's FOV that AI too stupid to see.

Parameters:
    0: _player - Player <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(revealFOV),_this);

params[
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _player) exitWith {};

GVAR(unitsDetected) = [];
GVAR(revealing) = true;

addMissionEventHandler["Draw3D", {
    if !GVAR(revealing) exitWith {
        removeMissionEventHandler[_thisEvent, _thisEventHandler];
    };

    GVAR(unitsDetected) apply {
        drawIcon3D[
            '\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa',
            [0.8, 0.0, 0.0, 0.75],
            getPosATLVisual _x vectorAdd [0, 0, -1],
            1, 1, 0,
            getText(configOf _x >> "displayName"), 2, 0.025, "RobotoCondensed", "center", false
        ];
    };
}];

_this spawn {
    params["_player"];

    /*private _dirMarker = createMarker["playerdir", getPos _player];
    _dirMarker setMarkerShape "POLYLINE";
    _dirMarker setMarkerColor "ColorRed";
    _dirMarker setMarkerAlpha 1;
    openMap true;*/

    private _timeout = diag_tickTime + GVAR(revealDuration);

    while { GVAR(revealing) } do {
        private _dir1 = getCameraViewDirection _player;
        //private _dir2 = [_dir1, GVAR(revealCone)] call BIS_fnc_rotateVector2D;
        //private _dir3 = [_dir1, -GVAR(revealCone)] call BIS_fnc_rotateVector2D;
        private _pos = positionCameraToWorld[0,0,0];

        /*_dirMarker setMarkerPolylineLocal(flatten[
            getPos _player vectorAdd (_dir1 vectorMultiply GVAR(revealRadius)) select[0, 2],
            _pos select[0, 2],
            getPos _player vectorAdd (_dir2 vectorMultiply GVAR(revealRadius)) select[0, 2],
            getPos _player vectorAdd (_dir3 vectorMultiply GVAR(revealRadius)) select[0, 2],
            _pos select[0, 2]
        ]);*/

        private _bisDir = atan(_dir1 # 0 / _dir1 # 1);
        if (_dir1 # 1 < 0) then { _bisDir = _bisDir + 180 };

        GVAR(unitsDetected) = ((_player nearObjects["CAManBase", GVAR(revealRadius)]) - [_player]) select {
            (alive _x) && { side _x isNotEqualTo side _player } &&
            { [_pos, _bisDir, 2 * GVAR(revealCone), getPosWorld _x] call BIS_fnc_inAngleSector } &&
            { !lineIntersects[AGLToASL _pos, getPosASL _x, vehicle _player, _x] }
        } apply {
            group _player reveal[_x, 4];
            _x;
        };

        uiSleep 0.25;

        if (diag_tickTime > _timeout) then {
            GVAR(revealing) = false;
        };
    };

    TRACE_1(QFUNC(revealFOV_DONE),_this);

    //deleteMarker _dirMarker;
};


nil;
