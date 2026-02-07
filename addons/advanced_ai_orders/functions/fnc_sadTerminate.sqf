#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_sadTerminate

Description:
    Terminate a running op.

Parameters:
    0: _player - Player calling for termination <OBJECT>
    1: _missionId - Mission ID to terminate <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(sadTerminate),_this);

if !assert(params[
    ["_player", nil, [objNull]],
    ["_missionId", nil, [""]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

private _sadMissions = missionNamespace getVariable QGVAR(sadMissions);
if !assert(!isNil "_sadMissions") exitWith {};

private _mission = _sadMissions get _missionId;
if !assert(!isNil "_mission") exitWith {};

_mission set["abort", true];
INFO_2("SAD mission %1: termination requested by player: %2",_missionId,_player);

nil;
