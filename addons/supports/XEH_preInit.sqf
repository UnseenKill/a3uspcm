#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(moduleSupportProvider) = objNull;
GVAR(moduleProviders) = createHashMap;
GVAR(supportBuildings) = createHashMap;
GVAR(tentGuysGroup) = createGroup[resistance, false];
GVAR(tentGuysGroup) setVariable["ace_map_hideBlueForceMarker", true];

[{
    [] call FUNC(appendBuildables);
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
