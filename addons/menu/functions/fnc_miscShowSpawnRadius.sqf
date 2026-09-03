#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscShowSpawnRadius

Description:
    Show the spawn radius of all (discovered) enemy locations on the map.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscShowSpawnRadius;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscShowSpawnRadius),_this);

if (!visibleMap) then {
    openMap true;
};

mapAnimAdd[0.5, 1, [worldSize / 2, worldSize / 2]];
mapAnimCommit;

private _markers = flatten[outposts, airportsX, milbases, resourcesX, factories, seaports] select {
    (markerAlpha _x > 0) && { sidesX getVariable[_x, sideUnknown] != teamPlayer };
} apply {
    private _marker = createMarkerLocal[format["%1:%2", _x, [] call CBA_fnc_createUUID], markerPos _x];
    TRACE_2(QFUNCMAIN(mapShowSpawnRadius),_x,_marker);

    _marker setMarkerAlphaLocal 1;
    _marker setMarkerBrushLocal "DiagGrid";
    _marker setMarkerColorLocal "ColorYellow";
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerSizeLocal[distanceSPWN, distanceSPWN];

    _marker;
};

TRACE_1(QFUNCMAIN(mapShowSpawnRadius),_markers);

_markers spawn {
    waitUntil { !visibleMap };
    _this apply { deleteMarker _x };
};

nil;
