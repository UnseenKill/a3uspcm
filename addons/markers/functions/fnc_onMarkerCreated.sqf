#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_onMarkerCreated

Description:
    Event handler for marker creation.

Parameters:
    0: _marker - Marker name <STRING>
    1: _channel - Channel ID <NUMBER>
    2: _owner - Owner object <OBJECT>
    3: _local - Creation event was local <BOOL>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onMarkerCreated),_this);

params[
    ["_marker", "", [""]],
    ["_channel", 0, [0]],
    ["_owner", objNull, [objNull]],
    ["_local", false, [false]]
];

nil;
