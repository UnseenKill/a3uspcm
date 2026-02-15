#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_loadMarkers

Description:
    Load stored markers from the save.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["A3USPCM_markers_storedMarkers"]
TRACE_1(QFUNC(loadMarkers),_this);

if !(isNil QGVAR(storedMarkers)) exitWith {
    INFO("Markers already loaded, skipping...");
};

INFO("Markers not loaded, initializing...");

[QGVAR(storedMarkers)] call A3A_fnc_getStatVariable;

if (isNil QGVAR(storedMarkers)) then {
    INFO("No saved markers found, initializing empty map");
    GVAR(storedMarkers) = createHashMap;
} else {
    INFO("Loading saved markers");
    TRACE_2(QFUNC(loadMarkers),typeName GVAR(storedMarkers),GVAR(storedMarkers));

    if (GVAR(storedMarkers) isEqualType []) then {
        GVAR(storedMarkers) = createHashMapFromArray GVAR(storedMarkers);
    } else {
        WARNING("Invalid markers data type, initializing with empty array");
        TRACE_1("invalid value",GVAR(storedMarkers));

        GVAR(storedMarkers) = createHashMap;
    };
};

nil;
