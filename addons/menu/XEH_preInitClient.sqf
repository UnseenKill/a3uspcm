#include "script_component.hpp"

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
    { call EFUNC(aafc,toggleROEAll) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(aafc,HotkeysToggleUI),
    [ELSTRING(aafc,HotkeysToggleUI), ELSTRING(aafc,HotkeysToggleUITooltip)],
    {},
    { createDialog QEGVAR(aafc,ConfigTablet) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(vehicles,HotkeysSwitchSeat),
    [ELSTRING(vehicles,HotkeysSwitchSeat), ELSTRING(vehicles,HotkeysSwitchSeatTooltip)],
    {},
    { [] call EFUNC(vehicles,switchSeat) }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QEGVAR(vehicles,HotkeysMeepMeep),
    [ELSTRING(vehicles,HotkeysMeepMeep), ELSTRING(vehicles,HotkeysMeepMeepTooltip)],
    {},
    {
        !(isNull objectParent player) &&
        {[objectParent player, player] call EFUNC(vehicles,meepMeepCanDoAction)} &&
        {[objectParent player, player] call EFUNC(vehicles,meepMeepDoAction)}
    }
] call CBA_fnc_addKeybind;

GVAR(DiaryActions) = createHashMap;
GVAR(IntelCleanup) = false;
GVAR(IntelMarkers) = createHashMap;
GVAR(Timers) = [false, false];

[{
    allCurators apply {
        _x addCuratorEditableObjects[[player], false];
    };

    [] call FUNC(diaryInitialize);
    [] call FUNC(timerRestore);
    [] call FUNC(commanderMenuAppend);

    if (!isNil QGVAR(AdditionalBuildables) && { GVAR(AdditionalBuildables) isEqualType [] }) then {
        INFO("Applying additional buildables from server");
        GVAR(AdditionalBuildables) apply {
            TRACE_1(QFUNC(loadAdditionalBuildables),_x);
            A3A_buildableObjects pushBackUnique _x;
        };
    };

    if (!isNil QGVAR(AdditionalStatics) && { GVAR(AdditionalStatics) isEqualType [] }) then {
        INFO("Applying additional statics from server");
        GVAR(AdditionalStatics) apply {
            TRACE_1(QFUNC(loadAdditionalStatics),_x);

            A3A_faction_reb get "staticMGs" pushBackUnique (_x select 0);
            A3U_blackMarketStock pushBack [
                _x select 0, // classname
                _x select 1, // price
                "STATICMG", // type
                {true} // condition
            ];
        };
    };

    if (!isNil QGVAR(AdditionalVehicles) && { GVAR(AdditionalVehicles) isEqualType [] }) then {
        INFO("Applying additional vehicles from server");

        private _typeMap = createHashMapFromArray[
            ["vehiclesLightArmed", "TANK"],
            ["vehiclesCivCar", "UNARMEDCAR"],
            ["vehiclesCivHeli", "HELI"],
            ["vehiclesCivPlane", "PLANE"],
            ["vehiclesCivBoat", "BOAT"],
            ["vehiclesPlane", "PLANE"],
            ["vehiclesBoat", "BOAT"]
        ];

        GVAR(AdditionalVehicles) apply {
            _x params[["_className","",[""]],["_price",0,[0]],["_type","",[""]]];

            TRACE_3(QFUNC(loadAdditionalVehicles),_className,_price,_type);

            A3A_faction_reb get _type pushBackUnique _className;

            if (A3U_blackMarketStock findIf { _x select 0 isEqualTo _className } isNotEqualTo -1) then {
                WARNING_2("%1(%2): black market config found; not adding to BM",QFUNC(loadAdditionalVehicles),_className);
            } else {
                A3U_blackMarketStock pushBack [
                    _className, // classname
                    _price, // price
                    _typeMap get _type, // type
                    {true} // condition
                ];
            };
        };
    };

    private _uniforms = GVAR(additionalUndercoverClothesClassList) splitString "," apply { trim _x } select {
        !isNil {
            switch true do {
                case !(_x isKindOf["Uniform_Base", configFile >> "CfgWeapons"]): {
                    WARNING_2("%1: classname %2 is not a valid uniform class",QFUNC(loadAdditionalUndercoverClothes),str _x);
                };
                case (_x in (A3A_faction_civ get "uniforms")): {
                    WARNING_2("%1: classname %2 is already in the list of available undercover clothes",QFUNC(loadAdditionalUndercoverClothes),str _x);
                };
                default {
                    INFO_2("%1: adding %2 to list of available undercover clothes",QFUNC(loadAdditionalUndercoverClothes),str _x);
                    true;
                };
            };
        };
    };

    A3A_faction_civ get "uniforms" append _uniforms;
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
