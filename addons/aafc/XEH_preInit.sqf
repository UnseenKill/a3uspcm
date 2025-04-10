#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(groups) = [];

[{
    if GVAR(autoGroupAtStart) then {
        INFO("Auto-grouping A/A vehicles");

        [] call FUNC(autoGroupVehicles);
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);
