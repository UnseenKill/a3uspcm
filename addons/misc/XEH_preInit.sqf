#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(revealCone) = 45;
GVAR(revealDuration) = 5;
GVAR(revealRadius) = 250;

[{
    if GVAR(addAceTrenchesToBuildings) then {
        [
            "ace_trenches_finished",
            { call FUNC(onAceTrenchesFinished) }
        ] call CBA_fnc_addEventHandler;
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);

[
    "Snake_random_F",
    0,
    ["ACE_MainActions"],
    [
        QGVAR(SquashSnake),
        localize LSTRING(SquashSnake),
        "",
        { call FUNC(squashSnake) },
        { alive _target }
    ] call ace_interact_menu_fnc_createAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

nil;
