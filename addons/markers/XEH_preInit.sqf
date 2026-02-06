#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(markerNameMapping) = createHashMap;
GVAR(storedMarkers) = false;

[
    {
        INFO("loading stored markers");
        if is3DENPreview exitWith { GVAR(storedMarkers) = createHashMap };
        [] call FUNC(loadMarkers);
    }
] call FUNCMAIN(utilOnA3UClientInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving permanent markers");
    [QGVAR(storedMarkers), +GVAR(storedMarkers)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;
