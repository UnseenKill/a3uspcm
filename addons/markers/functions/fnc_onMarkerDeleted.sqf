#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_onMarkerDeleted

Description:
    Event handler for marker deletion.

Parameters:
    0: _marker - Marker name <STRING>
    1: _local - Deletion event was local <BOOL>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onMarkerDeleted),_this);

if !assert(isServer) exitWith {};

params[
    ["_marker", "", [""]],
    ["_local", false, [false]]
];

GVAR(storedMarkers) deleteAt _marker;
[QGVAR(storedMarkers), GVAR(storedMarkers)] call A3A_fnc_setStatVariable;

nil;
