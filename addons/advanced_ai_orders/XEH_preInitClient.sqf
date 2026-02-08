#include "script_component.hpp"

// Why tf does this trigger in 3DEN anyways
if (!is3DEN) then {
    ["loadout", { call FUNC(onPlayerEventLoadout) }, true] call CBA_fnc_addPlayerEventHandler;
};

[CBA_EVENT_AAIO_RADIO_EQUIPPED, { call FUNC(onRadioEquipped) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAIO_RADIO_UNEQUIPPED, { call FUNC(onRadioUnequipped) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_ADVANCE_FORWARD, { call FUNC(advanceForward) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SAD_TERMINATE, { call FUNC(sadTerminate) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SEARCH_AND_DESTROY, { call FUNC(searchAndDestroy) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_ADVANCE_CYCLE_REFERENCE, { call FUNC(securityCycleReference) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SECURITY_PULL360, { call FUNC(securityPull360) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SECURITY_GUARD_FRONT, { call FUNC(securityGuardFront) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SECURITY_GUARD_REAR, { call FUNC(securityGuardRear) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SECURITY_RETURN_TO_POSITION, { call FUNC(securityReturnToPosition) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SHOW_NOTIFICATION, { call FUNC(showNotification) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_UPDATE_COMMS_MENU, { call FUNC(updateCommsMenu) }] call CBA_fnc_addEventHandler;

GVAR(haveGlobalKillEventHandler) = true;
GVAR(securityDistance) = 20;
GVAR(sadRallyDistance) = 100;
GVAR(sadSweepTime) = 240;
GVAR(sadStagingDistance) = 100;

[CBA_EVENT_SETTINGS_SET_SAD_RALLY_DISTANCE, {
    GVAR(sadRallyDistance) = _this;
    systemChat format[LLSTRING(Hint_SADRallyDistanceSet), GVAR(sadRallyDistance)];
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_SETTINGS_SET_SAD_STAGING_DISTANCE, {
    GVAR(sadStagingDistance) = _this;
    systemChat format[LLSTRING(Hint_SADStagingDistanceSet), GVAR(sadStagingDistance)];
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_SETTINGS_SET_SAD_SWEEP_TIME, {
    GVAR(sadSweepTime) = _this;
    systemChat format[LLSTRING(Hint_SADSweepTimeSet), GVAR(sadSweepTime)];
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_SETTINGS_SET_SECURITY_DISTANCE, {
    GVAR(securityDistance) = _this;
    systemChat format[LLSTRING(Hint_SecurityDistanceSet), GVAR(securityDistance)];
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_SETTINGS_SET_SECURITY_REFERENCE, {
    switch true do {
        case (!isNull cursorTarget): {
            GVAR(securityReference) = cursorTarget;
            systemChat format[LLSTRING(Hint_SecurityReferenceSet_Vehicle), getText(configOf cursorTarget >> "displayName")];
        };
        case (!isNil "_pos"): {
            GVAR(securityReference) = _pos;
            systemChat format[LLSTRING(Hint_SecurityReferenceSet_Position), mapGridPosition _pos];
        };
        default {
            systemChat LLSTRING(Hint_SecurityReferenceSet_NoTarget);
        };
    };

    TRACE_1("Security reference set to %1",GVAR(securityReference));
}] call CBA_fnc_addEventHandler;

nil;
