#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_onMarkerUpdated

Description:
    Event handler for marker update.

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
TRACE_1(QFUNC(onMarkerUpdated),_this);

if !assert(params[
    ["_marker", nil, [""]],
    ["_local", nil, [true]]
]) exitWith {};

[_marker, false] call FUNC(saveMarker);

nil;
