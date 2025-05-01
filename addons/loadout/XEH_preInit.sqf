#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(Loadouts) = false;

[
    {
        INFO("loading stored loadouts");
        [] call FUNC(initInteractions);
        if is3DENPreview exitWith {};
        [] call FUNC(getLoadouts);
    }
] call FUNCMAIN(utilOnA3UClientInitDone);

[QEGVAR(main,eventMainOnSaveGame), {
    INFO("saving loadouts");
    [QGVAR(Loadouts), +GVAR(Loadouts)] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;
