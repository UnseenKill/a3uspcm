#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_resupplyOnWaypointComplete

Description:
    "WaypointComplete" event handler

Parameters:
    0: _group - Group that completed the waypoint <GROUP>
    1: _wpIndex - Index of the completed waypoint <SCALAR>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(resupplyOnWaypointComplete),_this);

if !assert(params[
    ["_group", nil, [grpNull]],
    ["_wpIndex", nil, [0]]
]) exitWith {};

if (isPlayer leader _group) exitWith {};

private _wp = waypoints _group select _wpIndex;

TRACE_1(QFUNC(resupplyOnWaypointComplete),waypointType _wp);
TRACE_1(QFUNC(resupplyOnWaypointComplete),waypointName _wp);
TRACE_1(QFUNC(resupplyOnWaypointComplete),waypointDescription _wp);
TRACE_1(QFUNC(resupplyOnWaypointComplete),waypointStatements _wp);
TRACE_1(QFUNC(resupplyOnWaypointComplete),waypointPosition _wp);

if (
    (waypointType _wp isNotEqualTo "SCRIPTED" || { waypointDescription _wp isNotEqualTo "Land" }) &&
    {waypointStatements _wp findIf {_x find "LAND" isNotEqualTo -1} isEqualTo -1}
) exitWith { TRACE_1("IGNORE",waypointStatements _wp)};

[leader _group, LLSTRING(Resupply_UAVPilot_AnnounceLanding_Text)] call FUNC(resupplyPilotAnnounce);
[leader _group, objectParent leader _group] spawn FUNC(resupplyWaitForVehicle);

nil;
