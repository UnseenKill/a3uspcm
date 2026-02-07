#include "script_component.hpp"

// Loading suppressed by XEH_preInit.sqf
if (!ADDON) exitWith {};

[{
    [] call FUNC(loadTracks);
}] call FUNCMAIN(utilOnA3UServerInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving playlists");
    [QGVAR(tracks), +GVAR(tracks)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;

nil;
