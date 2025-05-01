#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_eraseMarkers

Description:
    Make permanent markers not so permanent.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_markers_fnc_eraseMarkers;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(eraseMarkers),_this);

if !isNil QGVAR(MapSingleClickEH) exitWith {
    INFO("ignoring duplicate feature activation");
};

if !visibleMap then {
    openMap true;
};

[
    localize LSTRING(HintCaption),
    localize LSTRING(HintEraseMarkers)
] call A3A_fnc_customHint;

GVAR(MapSingleClickEH) = addMissionEventHandler["MapSingleClick", {
	params["_units","_pos","_alt","_shift"];

    private _nearestMarker = [allMapMarkers, _pos] call BIS_fnc_nearestPosition;

    if !(_nearestMarker in GVAR(markerNameMapping)) exitWith {
        [
            localize LSTRING(HintCaption),
            localize LSTRING(HintNoMarkerFound)
        ] call A3A_fnc_customHint;
        playSound "A3AP_UiFailure";
    };

    private _markerId = GVAR(markerNameMapping) get _nearestMarker;
    deleteMarker _nearestMarker;

    GVAR(markerNameMapping) deleteAt _nearestMarker;
    GVAR(storedMarkers) deleteAt _markerId;
}];

[] spawn {
    waitUntil { !visibleMap };
    removeMissionEventHandler["MapSingleClick", GVAR(MapSingleClickEH)];
    GVAR(MapSingleClickEH) = nil;
};

nil;
