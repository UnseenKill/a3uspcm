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
TRACE_1(QFUNC(loadTracks),_this);

INFO("Custom playlist not loaded, initializing...");

GVAR(tracks) = profileNamespace getVariable QGVAR(tracks);

if isNil QGVAR(tracks) then {
    INFO("No saved tracks found, using tracks from config");
    GVAR(tracks) = [];
} else {
    INFO("Loading saved playlist");

    if !(GVAR(tracks) isEqualType []) then {
        WARNING("Invalid playlist data type, initializing with config instead");
        TRACE_1("invalid value",GVAR(tracks));

        GVAR(tracks) = [];
    };
};

if (GVAR(tracks) isNotEqualTo []) then {
    GVAR(tracks) = createHashMapFromArray GVAR(tracks);
} else {
    GVAR(tracks) = createHashMap;

    ["Combat","Stealth","Night","Default"] apply {
        private _key = toLower _x;
        GVAR(tracks) set[_key, getArray(configFile >> QGVAR(Config) >> "Tracks" >> _x >> "tracks")];
    };
};

TRACE_1("loaded",GVAR(tracks));
publicVariable QGVAR(tracks);

nil;
