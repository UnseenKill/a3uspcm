#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_searchAndDestroy

Description:
    Make team/selection search and destroy position.

Parameters:
    0: _player - Player issuing order <OBJECT>
    1: _pos - Position to search and destroy <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(searchAndDestroy),_this);

if !assert(params[
    ["_player", nil, [objNull]],
    ["_missionPosition", nil, [[]]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

if (missionNamespace getVariable[QGVAR(sadSettingUp), false]) exitWith {
    WARNING("Search and Destroy: Mission already being set up, aborting.");
    [CBA_EVENT_SHOW_NOTIFICATION, [_player, LLSTRING(Menu_OrdersSAD_DisplayName), LLSTRING(OrdersSAD_Hint_AbortMissionPreparing)]] call CBA_fnc_localEvent;
};

private _sadMissions = missionNamespace getVariable[QGVAR(sadMissions), createHashMap];
missionNamespace setVariable[QGVAR(sadMissions), _sadMissions];
missionNamespace getVariable[QGVAR(sadSettingUp), true];

private _units = [_player] call FUNC(getGroupSelection);
private _event = [] call CBA_fnc_createUUID;
private _center = [_units apply { getPosATL _x }] call FUNCMAIN(utilGetCenter);
private _maxDistance = [_units, 0, {
    _accumulator max(_x distance _center);
}] call CBA_fnc_inject;

private _immobileUnits = _units select { currentCommand _x isEqualTo "STOP" };
if (_immobileUnits isNotEqualTo []) exitWith {
    _immobileUnits apply {
        WARNING_1("Search and Destroy: Unit is immobile, aborting: %1",_x);
        _x groupRadio "SentSupportNotAvailable";
    };

    [CBA_EVENT_SHOW_NOTIFICATION, [_player, LLSTRING(Menu_OrdersSAD_DisplayName), LLSTRING(OrdersSAD_Hint_AbortUnitsImmobile)]] call CBA_fnc_localEvent;
    missionNamespace setVariable[QGVAR(sadSettingUp), nil];
};

private _mission = createHashMapFromArray[
    ["abort", false],
    ["handler", nil],
    ["player", _player],
    ["position", _missionPosition],
    ["rally", nil],
    ["units", _units],
    ["waitingOn", []],
    ["wpEvent", [] call CBA_fnc_createUUID]
];
_sadMissions set[_event, _mission];

TRACE_1(QFUNC(searchAndDestroy),_maxDistance);

// Need a rally point if max distance > 10
if (_maxDistance > 10) then {
    private _rally = _center;
    private _handler = [_event, {
        params["_unit","_finished"];
        _thisArgs params["_event"];

        private _mission = missionNamespace getVariable QGVAR(sadMissions) get _event;
        _mission set["waitingOn", (_mission get "waitingOn") - [_unit]];

        TRACE_3(QFUNC(searchAndDestroyHandler),_finished,_unit,_thisArgs);

        if (!_finished) exitWith {
            WARNING_1("Search and Destroy: Unit failed to reach position, aborting: %1",_unit);
            [_event, _mission get "handler"] call CBA_fnc_removeEventHandler;
            _mission set["abort", true];
            _mission set["waitingOn", []];
        };
    }, [_event]] call CBA_fnc_addEventHandlerArgs;

    _mission set["rally", _rally];
    _mission set["handler", _handler];
    _mission set["waitingOn", +_units];

    _units apply {
        [_player, _x, _rally vectorAdd[5 - random 10, 5 - random 10, 0], 0, _event] spawn FUNC(assumePosition);
    };
};

[_event] spawn {
    params["_event"];
    private _mission = missionNamespace getVariable QGVAR(sadMissions) get _event;

    INFO_1("SAD mission %1: waiting for rally",_event);
    waitUntil { _mission get "waitingOn" isEqualTo [] };

    missionNamespace setVariable[QGVAR(sadSettingUp), nil];

    if (_mission get "abort") exitWith {
        INFO_1("SAD mission %1: aborted",_event);
        missionNamespace getVariable QGVAR(sadMissions) deleteAt _event;
    };

    INFO_1("SAD mission %1: rally reached; assuming mission",_event);

    private _playerGroup = group(_mission get "player");
    private _group = createGroup[side(_mission get "player"), true];
    private _needLeader = true;
    private["_marker","_pos","_wp"];

    _marker = createMarkerLocal[hashValue _group, _mission get "position"];
    _marker setMarkerTypeLocal "mil_end_noShadow";
    _marker setMarkerColorLocal "ColorGUER";
    _marker setMarkerTextLocal format["%1 %2", groupId _group, LLSTRING(Menu_OrdersSADShort_DisplayName)];

    _mission set["group", _group];
    _mission set["wpEventHandler", [
        _mission get "wpEvent", {
            params["_unit"];
            private _wp = currentWaypoint group _unit;
            _unit sideChat format[LLSTRING(OrdersSAD_Hint_ReachedWaypoint), str waypointDescription(waypoints group _unit select _wp)];
        }
    ] call CBA_fnc_addEventHandler];

    _mission get "units" apply {
        _x setVariable[QGVAR(missionId), _event];
        _x setVariable[QGVAR(groupId), groupId _x];
        _x setVariable[QGVAR(assignedTeam), assignedTeam _x];
        _x setVariable[QGVAR(killedEH), _x addEventHandler["Killed", {
            TRACE_1(QFUNC(searchAndDestroyKilled),_this);
            params["_unit"];

            private _event = _unit getVariable QGVAR(missionId);
            private _mission = missionNamespace getVariable QGVAR(sadMissions) get _event;

            TRACE_2(QFUNC(searchAndDestroyKilled),_event,RETNIL(_mission));

            if (isNil "_mission") exitWith {};

            private _alive = (_mission get "units") findIf { alive _x };
            private _leader = leader group _unit;

            TRACE_3(QFUNC(searchAndDestroyKilled),_unit,_alive,_leader);

            if (_unit isNotEqualTo _leader) then {
                _leader sideChat format[LLSTRING(OrdersSAD_Hint_UnitKilledNonLeader), groupId _unit, name _unit];
            } else {
                if (_alive >= 0) then {
                    private _newLeader = (_mission get "units") select _alive;
                    group _unit selectLeader _newLeader;
                    _newLeader sideChat format[LLSTRING(OrdersSAD_Hint_UnitKilledLeader), name _unit];
                };
            };

            _mission set["abort", _alive == -1];
        }]];

        [_x] join _group;

        if _needLeader then {
            _needLeader = false;
            _group selectLeader _x;
        };
    };

    allCurators apply { _x addCuratorEditableObjects[units _group, false] };

    _group setBehaviour "AWARE";
    _group setCombatMode "YELLOW";
    leader _group sideChat LLSTRING(OrdersSAD_Hint_StartingTasking);

    [CBA_EVENT_UPDATE_COMMS_MENU, [_mission get "player"]] call CBA_fnc_localEvent;

    sleep 2;

    _pos = (_mission get "position") getPos[GVAR(sadStagingDistance), (_mission get "position") getDir leader _group];
    _wp = _group addWaypoint[_pos, 0];
    _wp setWaypointDescription LLSTRING(OrdersSAD_WaypointName_Staging);
    _wp setWaypointType "MOVE";
    _wp setWaypointSpeed "NORMAL";
    _wp setWaypointBehaviour "AWARE";
    _wp setWaypointCombatMode "YELLOW";
    _wp setWaypointStatements["true", format[QUOTE(if (local this) then {[ARR_2(QQUOTE(%1),[this])] call CBA_fnc_localEvent}), _mission get "wpEvent"]];

    _wp = _group addWaypoint[_mission get "position", 0];
    _wp setWaypointDescription LLSTRING(OrdersSAD_WaypointName_Objective);
    _wp setWaypointType "SAD";
    _wp setWaypointTimeout[GVAR(sadSweepTime) * 2 / 3, GVAR(sadSweepTime), GVAR(sadSweepTime) * 4 / 3];
    _wp setWaypointCompletionRadius 30;
    _wp setWaypointStatements["true", format[QUOTE(if (local this) then {[ARR_2(QQUOTE(%1),[this])] call CBA_fnc_localEvent}), _mission get "wpEvent"]];

    _pos = (_mission get "position") getPos[GVAR(sadRallyDistance), (_mission get "position") getDir leader _group];
    _wp = _group addWaypoint[_pos, 20];
    _wp setWaypointDescription LLSTRING(OrdersSAD_WaypointName_Rally);
    _wp setWaypointType "MOVE";
    _wp setWaypointSpeed "NORMAL";
    _wp setWaypointBehaviour "AWARE";
    _wp setWaypointCombatMode "YELLOW";
    _wp setWaypointStatements["true", format[QUOTE(if (local this) then {[ARR_2(QQUOTE(%1),[this])] call CBA_fnc_localEvent}), _mission get "wpEvent"]];

    waitUntil { (_mission get "abort") || { currentWaypoint _group isEqualTo 4 } };

    [CBA_EVENT_UPDATE_COMMS_MENU, [_mission get "player"]] call CBA_fnc_localEvent;
    [_mission get "wpEvent", _mission get "wpEventHandler"] call CBA_fnc_removeEventHandler;
    deleteMarker _marker;

    if (_mission get "abort") then {
        INFO_1("SAD mission %1: aborted during execution",_event);

        if ((_mission get "units") findIf { alive _x } == -1) then {
            ["TaskFailed", [LLSTRING(Menu_OrdersSAD_DisplayName), LLSTRING(OrdersSAD_Hint_MissionAbortAllDead)]] call BIS_fnc_showNotification;
        } else {
            ["TaskFailed", [LLSTRING(Menu_OrdersSAD_DisplayName), LLSTRING(OrdersSAD_Hint_MissionAbortTasking)]] call BIS_fnc_showNotification;
        };
    } else {
        INFO_1("SAD mission %1: completed",_event);
        ["TaskSucceeded", [LLSTRING(Menu_OrdersSAD_DisplayName), LLSTRING(OrdersSAD_Hint_MissionAbortSuccess)]] call BIS_fnc_showNotification;
    };

    leader _group sideChat format[LLSTRING(OrdersSAD_Hint_RejoiningGroup), groupId _playerGroup];
    (_mission get "units") select { alive _x } apply {
        _x removeEventHandler["Killed", _x getVariable QGVAR(killedEH)];
        _x joinAs[_playerGroup, _x getVariable QGVAR(groupId)];
        _x assignTeam(_x getVariable QGVAR(assignedTeam));
    };
};

nil;
