#include "script_component.hpp"

[] call FUNC(initVanillaInteractions);

["ACE_controlledUAV", { call FUNC(addDroneActions) }] call CBA_fnc_addEventHandler;

nil;
