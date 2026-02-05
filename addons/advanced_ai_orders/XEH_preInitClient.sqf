#include "script_component.hpp"

["loadout", { call FUNC(onPlayerEventLoadout) }, true] call CBA_fnc_addPlayerEventHandler;
[CBA_EVENT_AAIO_RADIO_EQUIPPED, { call FUNC(onRadioEquipped) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAIO_RADIO_UNEQUIPPED, { call FUNC(onRadioUnequipped) }] call CBA_fnc_addEventHandler;

nil;
