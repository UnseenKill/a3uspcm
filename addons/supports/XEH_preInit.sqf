#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(moduleSupportProvider) = objNull;
GVAR(moduleProviders) = createHashMap;
GVAR(supportBuildings) = createHashMap;
GVAR(supportSpecialists) = false;
GVAR(tentGuysGroup) = createGroup[resistance, false];
GVAR(tentGuysGroup) setVariable["ace_map_hideBlueForceMarker", true];

[{
    [] call FUNC(appendBuildables);
    [] call FUNC(loadSaved);
}] call FUNCMAIN(utilOnA3UClientInitDone);

configProperties[configFile >> QGVAR(Config) >> "Events", "true"] apply {
    [configName _x, compile getText(_x)] call CBA_fnc_addEventHandler;
};

nil;
