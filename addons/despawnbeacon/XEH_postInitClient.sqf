#include "script_component.hpp"

[] call FUNC(initItemContextMenu);

[CBA_EVENT_DSB_POSTINIT, { call FUNC(onClientPostInitDSB) }] call CBA_fnc_addEventHandler;

nil;
