#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(storedMarkers) = false;

[
    {
        INFO("loading stored markers");
        if is3DENPreview exitWith { GVAR(storedMarkers) = createHashMap };
        [] call FUNC(loadMarkers);
    }
] call FUNCMAIN(utilOnA3UClientInitDone);
