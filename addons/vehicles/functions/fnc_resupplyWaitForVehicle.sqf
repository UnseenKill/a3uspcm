#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_resupplyWaitForVehicle

Description:
    Go through the motions.

Parameters:
    0: _unit - Unit to wait for <OBJECT>
    1: _vehicle - Vehicle to wait for <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(resupplyWaitForVehicle),_this);

if !assert(params[
    ["_unit", nil, [objNull]],
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};
if !assert(!isNull _vehicle) exitWith {};
if !assert(canSuspend) exitWith {};

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

    // Check which direction rotor is, well, rotated to. Wait a second. Check
    // again. If it's the same, then we can be reasonably sure we're either 
    // extremely lucky or the rotor is stopped.
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

nil;
