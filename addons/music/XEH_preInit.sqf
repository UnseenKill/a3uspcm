#include "script_component.hpp"
#pragma hemtt ignore_variables ["A3USPCM_music_tracks"]

ADDON = false;

// skipWhenAnyAddonPresent[] in config.cpp does not seem to work...
if isClass(configFile >> "CfgPatches" >> "A3A_ultimate_tracklist_editor") exitWith {
    INFO("Tracklist editor donated to A3U detected; doing nothing.");
};

#include "XEH_PREP.hpp"
ADDON = true;

GVAR(tracks) = nil;

nil;
