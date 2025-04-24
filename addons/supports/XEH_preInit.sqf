#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(moduleSupportProvider) = objNull;
GVAR(moduleProviders) = createHashMap;

nil;
