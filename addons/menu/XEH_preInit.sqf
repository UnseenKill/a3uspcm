#include "script_component.hpp"

ADDON = false;

if !hasInterface exitWith {
    ADDON = true;
};

#include "XEH_PREP.hpp"

/*
[ELSTRING(common,WeaponsCategory), "MRT_SwitchItemNextClass_R", [LSTRING(railNext), LSTRING(railNext_tooltip)], {
    [1, "next"] call FUNC(switchAttachment) // return
}, {}, [DIK_L, [false, true, false]]] call CBA_fnc_addKeybind;
*/

ADDON = true;
