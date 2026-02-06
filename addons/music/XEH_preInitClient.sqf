#include "script_component.hpp"

// Loading suppressed by XEH_preInit.sqf
if (!ADDON) exitWith {};

GVAR(lastTracks) = [];
GVAR(waitScript) = nil;

[{
    if GVAR(overrideMusic) then {
        [] call FUNC(overrideMusic);
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
