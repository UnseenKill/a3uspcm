#include "script_component.hpp"

A3UEUESRS_ADDON_CHECK_AND_BOUNCE();

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(moduleSupportProvider) = objNull;
GVAR(moduleProviders) = createHashMap;
GVAR(supportBuildings) = createHashMap;
GVAR(supportSpecialists) = false;
GVAR(supportSpecialistsMissions) = createHashMap;
GVAR(tentGuysGroup) = createGroup[resistance, false];
GVAR(tentGuysGroup) setVariable["ace_map_hideBlueForceMarker", true];

[{
    [] call FUNC(appendBuildables);
    [] call FUNC(initInteractions);
    [] call FUNC(loadSaved);
}] call FUNCMAIN(utilOnA3UClientInitDone);

[QEGVAR(main,eventMainOnSaveGame), {
    INFO("saving supports");
    [QGVAR(supportSpecialists), +GVAR(supportSpecialists)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;

configProperties[configFile >> QGVAR(Config) >> "Events", "true"] apply {
    [configName _x, compile getText(_x)] call CBA_fnc_addEventHandler;
};

nil;
