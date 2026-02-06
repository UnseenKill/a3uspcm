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

if !assert(params[
    ["_marker", nil, [""]],
    ["_channel", nil, [0]],
    ["_owner", nil, [objNull]],
    ["_local", nil, [true]]
]) exitWith {};

if (isNull _owner) exitWith { TRACE_1(QFUNC(onMarkerCreated),_owner) };
if (count keys GVAR(storedMarkers) >= GVAR(saveLimit)) exitWith {
    TRACE_1(QFUNC(onMarkerCreated),"Save limit reached");

    [
        LLSTRING(HintCaption),
        format[LLSTRING(HintSaveLimitHit), GVAR(saveLimit)]
    ] remoteExec["A3A_fnc_customHint", owner _owner];
    ["A3AP_UiFailure"] remoteExec["playSound", owner _owner];
};

[_marker, true] call FUNC(saveMarker);

nil;
