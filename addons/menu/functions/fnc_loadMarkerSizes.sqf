#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadMarkerSizes

Description:
    Restore changed markers

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["_markerSizes"]
TRACE_1(QFUNC(loadMarkerSizes),_this);

if (GVAR(MarkerSizes) isEqualTo false) then {
    INFO("loading changed markers");

    private["_markerSizes"];

    ["_markerSizes"] call A3A_fnc_getStatVariable;
    
    if (isNil "_markerSizes" || { !(_markerSizes isEqualType []) }) then {
        INFO("No saved markers found, initializing empty marker sizes hashmap");
        _markerSizes = createHashMap;
    } else {
        INFO("Loading changed markers from saved data");
        TRACE_1(QFUNC(loadMarkerSizes),_markerSizes);

        _markerSizes = createHashMapFromArray _markerSizes;
        _markerSizes apply {
            TRACE_2(QFUNC(loadMarkerSizes),_x,_y);
            _x setMarkerSize[_y, _y];
        };
    };

    GVAR(MarkerSizes) = _markerSizes;
};

nil;
