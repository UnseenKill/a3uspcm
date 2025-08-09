#include "script_component.hpp"

GVAR(contacts) = createHashMap;
GVAR(contactTracker) = false;
GVAR(contactUpdateInterval) = 1.75; // 1.75 seconds
GVAR(contactTrackDeadInterval) = 30; // Three minutes
GVAR(groups) = [];

publicVariable QGVAR(contacts);
publicVariable QGVAR(groups);

[{
    [QGVAR(StartContactTracking), { call FUNC(onStartContactTracking) }] call CBA_fnc_addEventHandler;

    if GVAR(autoGroupAtStart) then {
        INFO("Auto-grouping A/A vehicles");

        [] call FUNC(autoGroupVehicles);
    };

    if (GVAR(roeCorrectionInterval) isNotEqualTo 0) then {
        INFO("Starting ROE correction monitor");

        [] spawn FUNC(roeCorrectionMonitor);
    };
}] call FUNCMAIN(utilOnA3UServerInitDone);
