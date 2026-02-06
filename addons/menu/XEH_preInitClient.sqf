#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"

[
    ELSTRING(main,Title),
    QGVAR(InstantHeal),
    [LSTRING(Hotkeys_InstantHealSelf), LSTRING(Hotkeys_InstantHealSelfTooltip)],
    {},
    { [] call FUNCMAIN(healPlayer) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QGVAR(InstantHealGroup),
    [LSTRING(Hotkeys_InstantHealGroup), LSTRING(Hotkeys_InstantHealGroupTooltip)],
    {},
    { [] call FUNCMAIN(healGroup) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QGVAR(EmergencyInvincibility),
    [LSTRING(Hotkeys_EmergencyInvincibility), LSTRING(Hotkeys_EmergencyInvincibilityTooltip)],
    {},
    { [] call FUNCMAIN(emergencyInvincibility) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QGVAR(FireSmokeLauncher),
    [LSTRING(Hotkeys_FireSmokeLauncher), LSTRING(Hotkeys_FireSmokeLauncherTooltip)],
    {},
    { [] call FUNCMAIN(fireSmokeLauncher) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(weapons,ToggleSuppressors),
    [ELSTRING(weapons,Hotkeys_ToggleSuppressors), ELSTRING(weapons,Hotkeys_ToggleSuppressorsTooltip)],
    {},
    { [player] call EFUNC(weapons,toggleSuppressors) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(misc,RevealFOV),
    [ELSTRING(misc,Hotkeys_RevealFOV), ELSTRING(misc,Hotkeys_RevealFOVTooltip)],
    {},
    { [player] call EFUNC(misc,revealFOV) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(misc,WakeupUnconscious),
    [ELSTRING(misc,Hotkeys_WakeupUnconscious), ELSTRING(misc,Hotkeys_WakeupUnconsciousTooltip)],
    {},
    { [player] call EFUNC(misc,wakeupUnconscious) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(aafc,HotkeysToggleROEAll),
    [ELSTRING(aafc,HotkeysToggleROEAll), ELSTRING(aafc,HotkeysToggleROEAllTooltip)],
    {},
    { [""] call EFUNC(aafc,toggleROEAll) }
] call CBA_fnc_addKeybind;

ADDON = true;

GVAR(DiaryActions) = createHashMap;
GVAR(IntelCleanup) = false;
GVAR(IntelMarkers) = createHashMap;
GVAR(Timers) = [false, false];

[{
    allCurators apply {
        _x addCuratorEditableObjects[[player], false];
    };

    [] call FUNC(diaryInitialize);

    if (!isNil QGVAR(AdditionalBuildables) && { GVAR(AdditionalBuildables) isEqualType [] }) then {
        INFO("Applying additional buildables from server");
        GVAR(AdditionalBuildables) apply {
            TRACE_1(QFUNC(loadAdditionalBuildables),_x);
            A3A_buildableObjects pushBackUnique _x;
        };
    };

}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
