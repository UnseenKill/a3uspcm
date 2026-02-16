#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_resupplyCheckEngineer

Description:
    Check if there is an engineer in the garrison of a marker.

Parameters:
    0: _marker - Marker to check for engineer presence <STRING>

Optional:

Returns:
    <BOOL> true if there is an engineer, false if not or if error.

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(resupplyCheckEngineer),_this);

if !assert(params[
    ["_marker", nil, [""]]
]) exitWith { false };
if !assert(markerType _marker isNotEqualTo "") exitWith { false };

private _garrison = garrison getVariable[_marker, []];
private _type = A3A_faction_reb get "unitEng";
_garrison findIf { _x isEqualTo _type } isNotEqualTo -1;
