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
_group addEventHandler["WaypointComplete", { call FUNC(resupplyOnWaypointComplete) }];

[leader _group, LLSTRING(Resupply_UAVPilot_AnnounceResupply_Text)] call FUNC(resupplyPilotAnnounce);

nil;
