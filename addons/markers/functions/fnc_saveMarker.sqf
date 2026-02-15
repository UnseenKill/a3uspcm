#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_saveMarker

Description:
    Save created/updated marker

Parameters:
    0: _marker - Marker name <STRING>
    1: _created - Whether the marker was newly created <BOOL>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(saveMarker),_this);

if !assert(params[
    ["_marker", nil, [""]],
    ["_created", nil, [false]]
]) exitWith {};

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

if (_created && { _marker in GVAR(storedMarkers) }) then {
    WARNING_1("Forced to overwrite marker %1",str _marker);
};

if (!_created && { !(_marker in GVAR(storedMarkers)) }) then {
    WARNING_1("Marker %1 not found in stored markers, but was updated. Saving it anyway.",str _marker);
};

INFO_1("Considering created marker %1 for saving",str _marker);
TRACE_2(QFUNC(saveMarker),_marker,_markerProperties);
GVAR(storedMarkers) set[_marker, _markerProperties];

nil;
