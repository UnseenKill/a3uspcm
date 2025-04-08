#include "..\script_component.hpp"
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
_this spawn {
    TRACE_1(QFUNC(activateBeacon),_this);

    params[
        ["_beacon", objNull, [objNull]],
        ["_player", objNull, [objNull]]
    ];

    if !assert(!isNull _beacon) exitWith {};
    if !assert(!isNull _player) exitWith {};

    [_beacon, _beacon] call ace_common_fnc_claim;
    [_player, "PutDown"] call ace_common_fnc_doGesture;

    _beacon animateSource["Terminal_source", 100, 1];
    _beacon animateSource["Terminal_source_sound", 100, 1];
    _beacon setVariable[QGVAR(active), true];

    _beacon setVariable["ace_cargo_canLoad", false];
    _beacon setVariable["ace_dragging_canCarry", false];
    _beacon setVariable["ace_dragging_canDrag", false];

    TRACE_1("waiting",_beacon);
    waitUntil { _beacon animationSourcePhase "Terminal_source" isEqualTo 100 };

    _beacon animateSource["Progress_source", 100, 2];

    TRACE_1("waiting",_beacon);
    waitUntil { _beacon animationSourcePhase "Progress_source" isEqualTo 100 };

    TRACE_1("looping",_beacon);

    private _marker = createMarkerLocal[[] call FUNCMAIN(utilGenerateUniqueId), getPosATL _beacon];
    _marker setMarkerTypeLocal "hd_dot_noShadow";
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerColorLocal "ColorBlack";
    _marker setMarkerTextLocal localize LSTRING(MarkerText);

    _beacon setVariable[QGVAR(marker), _marker];

    private _uav = createVehicle["I_UAV_01_F", getPosATL _beacon, [], 10, "NONE"];
    private _group = createGroup[side theBoss, true];
    private["_unit"];

    // Disable ACE3 BFT feature for this group
    _group setVariable["ace_map_hideBlueForceMarker", true];

    _unit = _group createUnit["I_UAV_AI", getPosATL _uav, [], 0, "NONE"];
    _unit moveInAny _uav;
    _unit = _group createUnit ["I_UAV_AI", getPos _beacon, [], 0, "NONE"];
    _unit moveInAny _uav;

    _uav allowDamage false;
    _uav hideObjectGlobal true;

    allPlayers apply {
        _x disableUAVConnectability[_uav, true];
    };

    _beacon setVariable[QGVAR(UAV), _uav];

    [objNull, _beacon] call ace_common_fnc_claim;

    private _forward = true;
    private _sourceStates = [50, 100];

    _beacon setVariable[QGVAR(ready), false];

    while { true } do {
        uiSleep 0.25;

        // Skip animations etc. if noone is around to enjoy them
        if (allPlayers findIf { _beacon distance _x < 100 } isEqualTo -1) then {
            TRACE_1(QFUNC(activateBeacon_noPlayers),_beacon);
            uiSleep 10;
            continue;
        };

        private _phase = _beacon animationSourcePhase "Terminal_source";

        if (_phase isNotEqualTo (_sourceStates select _forward)) then {
            /*TRACE_2("transitioning",_forward,_phase);*/
        } else {
            if (_beacon getVariable[QGVAR(active), false] isEqualTo false) then {
                TRACE_1("abort loop",_beacon);
                break;
            };

            TRACE_2("change direction",_forward,_phase);
            _forward = !_forward;

            uiSleep 0.5;
            if GVAR(loopSound) then {
                _beacon say3D QEGVAR(assets,RadioWave);
            };

            _beacon animateSource["Terminal_source", (_sourceStates select _forward), 1];
        };
    };

    [_beacon, _beacon] call ace_common_fnc_claim;
    TRACE_1("exiting",_beacon);

    _beacon animateSource["Progress_source", 0, 2];
    _beacon animateSource["Terminal_source", 100, true];

    TRACE_1("waiting",_beacon);
    waitUntil { _beacon animationSourcePhase "Progress_source" isEqualTo 0 };

    _beacon animateSource["Terminal_source", 0, 1];
    _beacon animateSource["Terminal_source_sound", 0, 1];

    TRACE_1("waiting",_beacon);
    waitUntil { _beacon animationSourcePhase "Terminal_source" isEqualTo 0 };
    TRACE_1("finished",_beacon);

    _beacon setVariable[QGVAR(ready), true];
    _beacon setVariable["ace_cargo_canLoad", true];
    _beacon setVariable["ace_dragging_canCarry", true];
    _beacon setVariable["ace_dragging_canDrag", true];

    [objNull, _beacon] call ace_common_fnc_claim;
};

nil;
