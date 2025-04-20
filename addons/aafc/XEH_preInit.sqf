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

    if (GVAR(roeCorrectionInterval) isNotEqualTo 0) then {
        INFO("Starting ROE correction monitor");

        [] spawn FUNC(roeCorrectionMonitor);
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);
