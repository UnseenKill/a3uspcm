#include "script_component.hpp"

GVAR(markerNameMapping) = createHashMap;
GVAR(markersRestored) = false;
GVAR(storedMarkers) = nil;

[{
    INFO("loading stored markers");
    if is3DENPreview exitWith { GVAR(storedMarkers) = createHashMap };
    [] call FUNC(loadMarkers);
}] call FUNCMAIN(utilOnA3UServerInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving permanent markers");

    if (isNil QGVAR(storedMarkers)) exitWith {};
    if !(GVAR(storedMarkers) isEqualType createHashMap) exitWith {
        WARNING("Invalid markers data type, expected hash map");
        TRACE_1("invalid value",GVAR(storedMarkers));
    };

    [QGVAR(storedMarkers), +GVAR(storedMarkers)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;

nil;
