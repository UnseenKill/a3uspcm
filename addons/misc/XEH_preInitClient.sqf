#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(revealCone) = 45;
GVAR(revealDuration) = 5;
GVAR(revealRadius) = 250;

[CBA_EVENT_A3U_FLAGACTION, { call FUNC(onA3UFlagActionEvent) }] call CBA_fnc_addEventHandler;
[] spawn FUNC(overrideFlagActionSQF);

[{
    if GVAR(aceFortifyEnable) then {
        [] call FUNC(setupAceFortifyModule);
    };

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
        LLSTRING(SquashSnake),
        "",
        { call FUNC(squashSnake) },
        { alive _target }
    ] call ace_interact_menu_fnc_createAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
    "##Uniform",
    ["CARGO","BACKPACK_CONTAINER"],
    LSTRING(WearClothes),
    [],
    "",
    { true },
    { call FUNC(wearClothes) },
    true
] call CBA_fnc_addItemContextMenuOption;

nil;
