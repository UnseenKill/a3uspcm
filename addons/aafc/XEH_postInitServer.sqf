#include "script_component.hpp"

GVAR(contacts) = createHashMap;
GVAR(contactTracker) = false;
GVAR(groups) = [];
// Additionally check if a missile fired by an A/A unit is allowed to "live";
// i.e. if that unit isn't allowed to fire, but Arma still thinks so, delete
// the projectile...
GVAR(missileSafetyNet) = true;

publicVariable QGVAR(contacts);
publicVariable QGVAR(globalROE);
publicVariable QGVAR(groups);

[CBA_EVENT_AAFC_ROE_MONITOR, {
    [_thisType, _thisId] call CBA_fnc_removeEventHandler;

    if (GVAR(roeCorrectionInterval) isNotEqualTo 0) then {
        INFO("Starting ROE correction monitor");

        [] spawn FUNC(roeCorrectionMonitor);
    };
}] call CBA_fnc_addEventHandlerArgs;

[CBA_EVENT_AAFC_SET_ROE_GLOBAL, {
    TRACE_1(CBA_EVENT_AAFC_SET_ROE_GLOBAL,_this);

    if !assert(params[
        ["_newROE", nil, [0]]
    ]) exitWith {};

    GVAR(globalROE) = _newROE;
    publicVariable QGVAR(globalROE);
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_SET_ROE_GLOBAL, { call FUNC(enforceROE) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_SET_UNIT_CANFIRE, { call FUNC(setUnitCanFire) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_START_CONTACT_TRACK, { call FUNC(onStartContactTracking) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_UNIT_ROE_CHANGED, { call FUNC(acknowledgeROEChange) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_VEHICLES_UPDATE, { call FUNC(updateGroupVehicles) }] call CBA_fnc_addEventHandler;

[{
    if (isNil QGVAR(defaultInitialMode)) then {
        INFO("Setting default ROE to 'Hold Fire' since CBA setting not found.");
        GVAR(globalROE) = ROE_HOLDFIRE;
    } else {
        GVAR(globalROE) = [ROE_HOLDFIRE, ROE_FIREATWILL] select(GVAR(defaultInitialMode) isEqualTo "FC_DEFAULT_ANGRY");
        INFO_2("Setting default ROE to %1 based on CBA setting %2",GVAR(globalROE),GVAR(defaultInitialMode));
    };

    publicVariable QGVAR(globalROE);

    if GVAR(autoGroupAtStart) then {
        INFO("Auto-grouping A/A vehicles");

        [] call FUNC(autoGroupVehicles);
    };
}] call FUNCMAIN(utilOnA3UServerInitDone);

nil;
