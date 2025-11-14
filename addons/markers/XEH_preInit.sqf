#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(markerNameMapping) = createHashMap;
INIT_SAVE_GVAR(storedMarkers);

[{
    INFO("loading stored markers");
    [] call FUNC(loadMarkers);
}] call FUNCMAIN(utilOnA3UClientInitDone);

[QEGVAR(main,eventMainOnSaveGame), {
    INFO("saving permanent markers");
    [QGVAR(storedMarkers), +GVAR(storedMarkers)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;
