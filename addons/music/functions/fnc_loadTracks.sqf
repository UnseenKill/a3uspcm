#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_music_fnc_loadTracks

Description:
    Load tracks from the config file or saved game data

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["_tracks"]
TRACE_1(QFUNC(loadTracks),_this);

INFO("Custom playlist not loaded, initializing...");

private _tracks = GVAR(tracks);

if (_tracks isEqualTo false) then {
    INFO("No saved tracks found, using tracks from config");
} else {
    INFO("Loading saved playlist");

    if !(_tracks isEqualType []) then {
        WARNING("Invalid playlist data type, initializing with config instead");
        TRACE_1("invalid value",_tracks);

        _tracks = false;
    };
};

if (_tracks isNotEqualTo false) then {
    _tracks = createHashMapFromArray _tracks;
} else {
    _tracks = createHashMap;

    ["Combat","Stealth","Night","Default"] apply {
        private _key = toLower _x;
        _tracks set[_key, getArray(configFile >> QGVAR(Config) >> "Tracks" >> _x >> "tracks")];
    };
};

GVAR(tracks) = _tracks;
TRACE_1("loaded",GVAR(tracks));

nil;
