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

[
    ELSTRING(main,Title),
    QGVAR(EmergencyInvincibility),
    [LSTRING(Hotkeys_EmergencyInvincibility), LSTRING(Hotkeys_EmergencyInvincibilityTooltip)],
    {},
    {
        [] call FUNCMAIN(emergencyInvincibility);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QGVAR(FireSmokeLauncher),
    [LSTRING(Hotkeys_FireSmokeLauncher), LSTRING(Hotkeys_FireSmokeLauncherTooltip)],
    {},
    {
        [] call FUNCMAIN(fireSmokeLauncher);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(weapons,ToggleSuppressors),
    [ELSTRING(weapons,Hotkeys_ToggleSuppressors), ELSTRING(weapons,Hotkeys_ToggleSuppressorsTooltip)],
    {},
    {
        [player] call EFUNC(weapons,toggleSuppressors);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(misc,RevealFOV),
    [ELSTRING(misc,Hotkeys_RevealFOV), ELSTRING(misc,Hotkeys_RevealFOVTooltip)],
    {},
    {
        [player] call EFUNC(misc,revealFOV);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(misc,WakeupUnconscious),
    [ELSTRING(misc,Hotkeys_WakeupUnconscious), ELSTRING(misc,Hotkeys_WakeupUnconsciousTooltip)],
    {},
    {
        [player] call EFUNC(misc,wakeupUnconscious);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(aafc,HotkeysToggleROEAll),
    [ELSTRING(aafc,HotkeysToggleROEAll), ELSTRING(aafc,HotkeysToggleROEAllTooltip)],
    {},
    {
        [""] call EFUNC(aafc,toggleROEAll);
    }
] call CBA_fnc_addKeybind;

ADDON = true;

GVAR(AdditionalBuildables) = false;
GVAR(AdditionalStatics) = false;
GVAR(DiaryActions) = createHashMap;
GVAR(IntelCleanup) = false;
GVAR(IntelMarkers) = createHashMap;
GVAR(MarkerSizes) = false;
GVAR(Timers) = [false, false];

[
    {
        allCurators apply {
            _x addCuratorEditableObjects[[theBoss]];
        };

        if is3DENPreview exitWith {};
        [] call FUNC(loadAdditionalBuildables);
        [] call FUNC(loadAdditionalStatics);
        [] call FUNC(loadMarkerSizes);
        [] call FUNC(timerRestore);
        [] call FUNC(commanderMenuAppend);
    }
] call FUNCMAIN(utilOnA3UClientInitDone);
