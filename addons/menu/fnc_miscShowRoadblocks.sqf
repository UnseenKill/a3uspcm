#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscShowRoadblocks

Description:
    Show all roadblocks on the map.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscShowRoadblocks;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if !visibleMap then {
    openMap true;
};

mapAnimAdd[0.5, 1, [worldSize / 2, worldSize / 2]];
mapAnimCommit;

private _mapInfoRoot = if (isClass (missionConfigFile/"A3A"/"mapInfo"/toLower worldName)) then {missionConfigFile} else {configFile};
getArray (_mapInfoRoot/"A3A"/"mapInfo"/toLower worldName/"garrison") params ["", ["_mrkCSAT",[],[[]]], "", ["_controlsCSAT",[],[[]]]];

private _markers = controlsX apply {
    TRACE_1("control",_x);

    private _outskirts = !isOnRoad markerPos _x;
    private _marker = createMarkerLocal[format["%1_%2", QGVAR(Roadblock), _x], markerPos _x];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "mil_dot_noShadow";

    if _outskirts then {
        _marker setMarkerColorLocal "ColorCivilian";
    } else {
        _marker setMarkerColorLocal (["ColorBLUFOR","ColorOPFOR"] select (_x in _controlsCSAT));
    };

    _marker setMarkerTextLocal format["%1 (%2)", localize ([LSTRING(Miscellaneous_RoadblockMarkerText), LSTRING(Miscellaneous_OutskirtsMarkerText)] select _outskirts), _x];
    _marker;
};

_markers spawn {
    waitUntil { !visibleMap };

    {
        TRACE_1("deleteing temporary marker",_x);
        deleteMarker _x;
    } forEach _this;
};

nil;
