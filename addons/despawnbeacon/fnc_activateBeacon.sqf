#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_activateBeacon

Description:
    Activates the despawn beacon.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget] call A3USPCM_despawnbeacon_fnc_activateBeacon;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(activateBeacon),_this);

params[
    ["_beacon", objNull, [objNull]]
];

if !assert(!isNull _beacon) exitWith {};

private _marker = createMarkerLocal[[] call FUNCMAIN(utilGenerateUniqueId), getPosATL _beacon];
_marker setMarkerTypeLocal "hd_dot_noShadow";
_marker setMarkerShapeLocal "ICON";
_marker setMarkerColorLocal "ColorBlack";
_marker setMarkerTextLocal localize LSTRING(MarkerText);

_beacon setVariable[QGVAR(marker), _marker];

private _uav = createVehicle["I_UAV_01_F", getPosATL _beacon, [], 10, "NONE"];
private _group = createGroup[side theBoss, true];
private["_unit"];

_unit = _group createUnit["I_UAV_AI", getPosATL _uav, [], 0, "NONE"];
_unit moveInAny _uav;
_unit = _group createUnit ["I_UAV_AI", getPos _beacon, [], 0, "NONE"];
_unit moveInAny _uav;

_uav allowDamage false;
_uav hideObjectGlobal true;

_beacon setVariable[QGVAR(UAV), _uav];

allCurators apply { _x addCuratorEditableObjects[[_uav], true] };

if GVAR(loopSound) then {
    [_beacon] spawn {
        params["_beacon"];

        TRACE_1("sound loop start",_beacon);

        while { !isNull(_beacon) && (alive _beacon) && !isNull(_beacon getVariable[QGVAR(UAV), objNull]) } do {
            _beacon say3D QEGVAR(assets,RadioWave);
            uiSleep 4;
        };

        TRACE_1("sound loop end",_beacon);
    };
};

nil;
