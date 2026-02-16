#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_doAirVehicleResupply

Description:
    ACE3 interaction callback for air vehicle resupply.

Parameters:
    0: _target - Target vehicle <OBJECT>
    1: _player - Player interacting with the vehicle <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(doAirVehicleResupply),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};
if !assert(!isNull _player) exitWith {};

_target setVariable[QGVAR(willResupply), true, true];

private _group = group driver _target;

_target removeAllEventHandlers "Engine";
_target addEventHandler["Engine", {
    TRACE_1("Engine",_this);
}];

_group removeAllEventHandlers "WaypointComplete";
_group addEventHandler["WaypointComplete", {
    TRACE_1("WaypointComplete",_this);
    params["_group","_wpIndex"];

    if (isPlayer leader _group) exitWith { TRACE_1("IGNORE",_wpIndex) };

    private _wp = waypoints _group select _wpIndex;

    if (waypointStatements _wp findIf {_x find "LAND" isNotEqualTo -1} isEqualTo -1) exitWith { TRACE_1("IGNORE",waypointStatements _wp)};
    [leader _group, LLSTRING(Resupply_UAVPilot_AnnounceLanding_Text)] call FUNC(resupplyPilotAnnounce);
    [leader _group, objectParent leader _group] spawn {
        params["_unit","_vehicle"];

        private _to = diag_tickTime + 90;
        waitUntil { (!alive _vehicle) || { diag_tickTime > _to } || { isTouchingGround _vehicle } };

        if (!alive _vehicle) exitWith {};
        if !(isTouchingGround _vehicle) exitWith {
            [_unit, LLSTRING(Resupply_UAVPilot_AnnounceLandingFailed_Text)] call FUNC(resupplyPilotAnnounce);
        };

        [_unit, LLSTRING(Resupply_UAVPilot_AnnounceLandingSuccess_Text)] call FUNC(resupplyPilotAnnounce);
        _to = diag_tickTime + 90;
        waitUntil { (!alive _vehicle) || { diag_tickTime > _to } || { !isEngineOn _vehicle } };

        if (!alive _vehicle) exitWith {};
        if (isEngineOn _vehicle) exitWith {
            [_unit, LLSTRING(Resupply_UAVPilot_AnnounceEngineOffFailed_Text)] call FUNC(resupplyPilotAnnounce);
        };

        private _animationNames = ["rotor_1","hrotor","vrotor","mainrotor1"];
        private _animationIndex = _animationNames findIf { _x in animationNames _vehicle };
        private _ready = if (_animationIndex isEqualTo -1) then {
            WARNING_1("No suitable animation source found, skipping animation check for %1.",typeOf _vehicle);
            true;
        } else {
            private _animationPhase = _animationNames select _animationIndex;
            TRACE_1(QFUNC(doAirVehicleResupply),_animationPhase);

            _to = diag_tickTime + 120;

            waitUntil {
                private _state = _vehicle animationPhase _animationPhase;
                sleep 1;
                (!alive _vehicle) || { diag_tickTime > _to } ||
                { _state isEqualTo (_vehicle animationPhase _animationPhase) };
            };

            alive _vehicle && { diag_tickTime < _to };
        };

        if (!alive _vehicle) exitWith {};
        if (!_ready) exitWith {
             [_unit, LLSTRING(Resupply_UAVPilot_AnnounceRotorFailed_Text)] call FUNC(resupplyPilotAnnounce);
        };

        [_unit, LLSTRING(Resupply_UAVPilot_AnnounceVehicleReady_Text)] call FUNC(resupplyPilotAnnounce);

        [{
            call FUNC(resupplyAirVehicle);
        }, [_vehicle, _unit], GVAR(resupplyDelay)] call CBA_fnc_waitAndExecute;
    };
}];

[leader _group, LLSTRING(Resupply_UAVPilot_AnnounceResupply_Text)] call FUNC(resupplyPilotAnnounce);

nil;
