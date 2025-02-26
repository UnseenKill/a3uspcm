#include "script_component.hpp"

ADDON = false;

if !hasInterface exitWith {
    ADDON = true;
};

#include "XEH_PREP.hpp"

[
    ELSTRING(main,Title),
    QGVAR(InstantHeal),
    [LSTRING(Hotkeys_InstantHealSelf), LSTRING(Hotkeys_InstantHealSelfTooltip)],
    {},
    {
        [] call FUNCMAIN(healPlayer);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QGVAR(InstantHealGroup),
    [LSTRING(Hotkeys_InstantHealGroup), LSTRING(Hotkeys_InstantHealGroupTooltip)],
    {},
    {
        [] call FUNCMAIN(healGroup);
    }
] call CBA_fnc_addKeybind;

ADDON = true;

GVAR(DiaryActions) = createHashMap;
