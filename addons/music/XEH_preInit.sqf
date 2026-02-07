#include "script_component.hpp"
#pragma hemtt ignore_variables ["A3USPCM_music_tracks"]

ADDON = false;

// skipWhenAnyAddonPresent[] in config.cpp does not seem to work...
if isClass(configFile >> "CfgPatches" >> "A3A_ultimate_tracklist_editor") exitWith {
    INFO("Tracklist editor donated to A3U detected; doing nothing.");
};

#include "XEH_PREP.hpp"
ADDON = true;

GVAR(lastTracks) = [];
GVAR(tracks) = nil;
GVAR(waitScript) = nil;

[{
    [] call FUNC(loadTracks);

    if GVAR(overrideMusic) then {
        [] call FUNC(overrideMusic);
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving playlists");
    [QGVAR(tracks), +GVAR(tracks)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;
