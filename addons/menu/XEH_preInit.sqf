#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(A3UEUNSRS_seen) = isClass(configFile >> "CfgPatches" >> "a3ueunsrs_main");
GVAR(A3UEUNSVL_seen) = isClass(configFile >> "CfgPatches" >> "a3ueunsvl_main");
