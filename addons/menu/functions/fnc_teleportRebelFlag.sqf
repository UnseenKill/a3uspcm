#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_teleportRebelFlag

Description:
    Teleport rebel flag and respawn marker to player

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_teleportRebelFlag;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
["flagX", {
    params[
        ["_flag", objNull, [objNull]],
        ["_position", [], [[]]]
    ];

    if !assert(!isNull _flag) exitWith {};

    _flag setVariable[QGVAR(respawnMarkerPos), markerPos respawnTeamPlayer];
    _flag setVariable[QGVAR(teleportBackCallback), {
        params[
            ["_flag", objNull, [objNull]],
            ["_position", [], [[]]]
        ];

        if !assert(!isNull _flag) exitWith {};

        private _markerPos = _flag getVariable[QGVAR(respawnMarkerPos), _position];

        TRACE_2(QFUNCMAIN(teleportRebelFlag),markerPos respawnTeamPlayer,_markerPos);
        respawnTeamPlayer setMarkerPos _markerPos;
        _flag setVariable[QGVAR(respawnMarkerPos), nil];
    }];

    TRACE_2(QFUNCMAIN(teleportRebelFlag),markerPos respawnTeamPlayer,_position);
    respawnTeamPlayer setMarkerPos _position;
}] call FUNCMAIN(teleportRebelObject);

nil;
