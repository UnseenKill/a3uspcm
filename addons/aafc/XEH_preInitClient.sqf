#include "script_component.hpp"

[CBA_EVENT_AAFC_DIALOG_OPENED, {call FUNC(tabletEventOnOpen)}] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_DIALOG_SWITCHTAB, {call FUNC(tabletEventOnSwitchTab)}] call CBA_fnc_addEventHandler;

nil;
