#include "script_component.hpp"

ADDON = false;
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

[QEGVAR(main,eventMainOnSaveGame), {
    INFO("saving playlists");
    [QGVAR(tracks), +GVAR(tracks)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;
