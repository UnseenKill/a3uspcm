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

if !assert(isServer) exitWith {};

params[
    ["_marker", "", [""]],
    ["_channel", 0, [0]],
    ["_owner", objNull, [objNull]],
    ["_local", false, [false]]
];

if (isNull _owner) exitWith { TRACE_1(QFUNC(onMarkerCreated),_owner) };
if (count keys GVAR(storedMarkers) >= GVAR(saveLimit)) exitWith {
    TRACE_1(QFUNC(onMarkerCreated),"Save limit reached");

    [
        localize LSTRING(HintCaption),
        format[localize LSTRING(HintSaveLimitHit), GVAR(saveLimit)]
    ] remoteExec["A3A_fnc_customHint", owner _owner];
    playSound "A3AP_UiFailure";
};

private _markerProperties = [
    /* 00 */ markerAlpha _marker,
    /* 01 */ markerBrush _marker,
    /* 02 */ markerChannel _marker,
    /* 03 */ markerColor _marker,
    /* 04 */ markerDir _marker,
    /* 05 */ markerPolyline _marker,
    /* 06 */ markerPos _marker,
    /* 07 */ markerShadow _marker,
    /* 08 */ markerShape _marker,
    /* 09 */ markerSize _marker,
    /* 10 */ markerText _marker,
    /* 11 */ markerType _marker
];

GVAR(storedMarkers) set[_marker, _markerProperties];
[QGVAR(storedMarkers), GVAR(storedMarkers)] call A3A_fnc_setStatVariable;

nil;
