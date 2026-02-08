#include "script_component.hpp"
#pragma hemtt ignore_variables ["A3USPCM_loadout_Loadouts"]

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

A3UEUNSVL_ADDON_CHECK_AND_BOUNCE();

GVAR(Loadouts) = false;

[
    {
        INFO("loading stored loadouts");
        [] call FUNC(initInteractions);
        if is3DENPreview exitWith {};
        [] call FUNC(getLoadouts);
    }
] call FUNCMAIN(utilOnA3UClientInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving loadouts");
    [QGVAR(Loadouts), +GVAR(Loadouts)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;
