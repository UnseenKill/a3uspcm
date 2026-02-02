#include "script_component.hpp"

ADDON = false;

if isClass(configFile >> "CfgPatches" >> "A3A_ultimate_trader_selling") exitWith {
    INFO("Advanced trader selling donated to A3U detected; doing nothing.");
};

#include "XEH_PREP.hpp"
ADDON = true;
