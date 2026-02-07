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
[CBA_EVENT_SECURITY_PULL360, { call FUNC(securityPull360) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SECURITY_GUARD_FRONT, { call FUNC(securityGuardFront) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SECURITY_GUARD_REAR, { call FUNC(securityGuardRear) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_SHOW_NOTIFICATION, { call FUNC(showNotification) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_UPDATE_COMMS_MENU, { call FUNC(updateCommsMenu) }] call CBA_fnc_addEventHandler;

GVAR(securityDistance) = 20;

[CBA_EVENT_SETTINGS_SET_SECURITY_DISTANCE, {
    GVAR(securityDistance) = _this;
    systemChat format[LLSTRING(Hint_SecurityDistanceSet), GVAR(securityDistance)];
}] call CBA_fnc_addEventHandler;

nil;
