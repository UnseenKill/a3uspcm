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
#pragma hemtt ignore_variables ["_storedMarkers"]
TRACE_1(QFUNC(loadMarkers),_this);

if is3DENPreview exitWith { GVAR(storedMarkers) = createHashMap };

if (GVAR(storedMarkers) isEqualTo false) then {
    INFO("Markers not loaded, initializing...");

    private["_storedMarkers"];

    ["_storedMarkers"] call A3A_fnc_getStatVariable;

    if (isNil "_storedMarkers") then {
        INFO("No saved markers found, initializing empty map");
        _storedMarkers = createHashMap;
    } else {
        INFO("Loading saved markers");

        if (_storedMarkers isEqualType []) then {
            _storedMarkers = createHashMapFromArray _storedMarkers;
            [] call FUNC(restoreMarkers);
        } else {
            WARNING("Invalid markers data type, initializing with empty array");
            TRACE_1("invalid value",_storedMarkers);

            _storedMarkers = createHashMap;
        };
    };

    GVAR(storedMarkers) = _storedMarkers;
};

nil;
