#include "script_component.hpp"

// Loading suppressed by XEH_preInit.sqf
if (!ADDON) exitWith {};

[{
    [] call FUNC(loadTracks);
}] call FUNCMAIN(utilOnA3UServerInitDone);

nil;
