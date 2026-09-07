#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_drawSpawnRadius

Description:
    Draw spawn radius around custom waypoint position

Parameters:
    0: _player - Player requesting marker to be drawn <OBJECT>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(drawSpawnRadius),_this);

if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

if !assert(customWaypointPosition isNotEqualTo []) exitWith {};

private _marker = createMarkerLocal[format["_USER_DEFINED %1", [] call CBA_fnc_createUUID], customWaypointPosition, -1, _player];
_marker setMarkerAlphaLocal 1;
_marker setMarkerBrushLocal "DiagGrid";
_marker setMarkerColorLocal "ColorPink";
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerSizeLocal[distanceSPWN, distanceSPWN];

nil;
