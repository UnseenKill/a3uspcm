#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

[{
    if GVAR(addAceTrenchesToBuildings) then {
        [
            "ace_trenches_finished",
            { call FUNC(onAceTrenchesFinished) }
        ] call CBA_fnc_addEventHandler;
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);
