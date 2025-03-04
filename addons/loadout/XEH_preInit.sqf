#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(Loadouts) = false;

[
    {
        INFO("loading stored loadouts");
        [] call FUNC(getLoadouts);
    }
] call FUNCMAIN(utilOnA3UClientInitDone);
