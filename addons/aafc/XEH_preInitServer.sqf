#include "script_component.hpp"

GVAR(contacts) = createHashMap;
GVAR(contactTracker) = false;
GVAR(globalROE) = ROE_HOLDFIRE;
GVAR(groups) = [];

publicVariable QGVAR(contacts);
publicVariable QGVAR(globalROE);
publicVariable QGVAR(groups);

[CBA_EVENT_AAFC_SET_ROE_GLOBAL, {
    if !assert(params[
        ["_newROE", nil, [0]]
    ]) exitWith {};

    GVAR(globalROE) = _newROE;
    publicVariable QGVAR(globalROE);
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_SET_ROE_GLOBAL, { call FUNC(enforceROE) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_UNIT_ROE_CHANGED, { call FUNC(acknowledgeROEChange) }] call CBA_fnc_addEventHandler;

[{
    [CBA_EVENT_AAFC_START_CONTACT_TRACK, { call FUNC(onStartContactTracking) }] call CBA_fnc_addEventHandler;

    if GVAR(autoGroupAtStart) then {
        INFO("Auto-grouping A/A vehicles");

        [] call FUNC(autoGroupVehicles);
    };

    if (GVAR(roeCorrectionInterval) isNotEqualTo 0) then {
        INFO("Starting ROE correction monitor");

        [] spawn FUNC(roeCorrectionMonitor);
    };
}] call FUNCMAIN(utilOnA3UServerInitDone);

nil;
