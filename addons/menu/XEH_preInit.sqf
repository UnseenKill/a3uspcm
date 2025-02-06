#include "script_component.hpp"

ADDON = false;

if !hasInterface exitWith {
    ADDON = true;
};

#include "XEH_PREP.hpp"

[
    ELSTRING(main,Title),
    QGVAR(InstantHeal),
    [LSTRING(Hotkeys_InstantHeal), LSTRING(Hotkeys_InstantHealTooltip)],
    {},
    {
        [] call FUNCMAIN(healGroup);
    }
] call CBA_fnc_addKeybind;

ADDON = true;
