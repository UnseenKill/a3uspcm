// Common

[
    QEGVAR(menu,emergencyInvincibilityDuration), "SLIDER",
    [ELSTRING(menu,Settings_emergencyInvincibilityDuration_DisplayName), ELSTRING(menu,Settings_emergencyInvincibilityDuration_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 600, 20, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,emergencyInvincibilityCooldown), "SLIDER",
    [ELSTRING(menu,Settings_emergencyInvincibilityCooldown_DisplayName), ELSTRING(menu,Settings_emergencyInvincibilityCooldown_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 600, 60, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,fiaTransferFee), "SLIDER",
    [ELSTRING(menu,Settings_fiaTransferFee_DisplayName), ELSTRING(menu,Settings_fiaTransferFee_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 100, 10, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,recruitSkipEnemyCheck), "CHECKBOX",
    [ELSTRING(menu,Settings_recruitSkipEnemyCheck_DisplayName), ELSTRING(menu,Settings_recruitSkipEnemyCheck_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,lootboxCost), "SLIDER",
    [ELSTRING(menu,Settings_lootboxCost_DisplayName), ELSTRING(menu,Settings_lootboxCost_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 5000, 250, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,dsbCost), "SLIDER",
    [ELSTRING(menu,Settings_dsbCost_DisplayName), ELSTRING(menu,Settings_dsbCost_DisplayName)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 5000, 750, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(despawnbeacon,loopSound), "CHECKBOX",
    [ELSTRING(despawnbeacon,Settings_loopSound_DisplayName), ELSTRING(despawnbeacon,Settings_loopSound_DisplayName)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(util,cursorTargetActionDelay), "SLIDER",
    [ELSTRING(util,Settings_cursorTargetActionDelay_DisplayName), ELSTRING(util,Settings_cursorTargetActionDelay_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 5, 2.5, 1], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,additionalBuildablesStartEmpty), "CHECKBOX",
    [ELSTRING(menu,Settings_additionalBuildablesStartEmpty_DisplayName), ELSTRING(menu,Settings_additionalBuildablesStartEmpty_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(autouncompromize,escapeZoneRadius), "SLIDER",
    [ELSTRING(autouncompromize,Settings_escapeZoneRadius_DisplayName), ELSTRING(autouncompromize,Settings_escapeZoneRadius_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 2500, 800, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

// Zeus

[
    QEGVAR(zeus,enhanceZenContextMenu), "CHECKBOX",
    [ELSTRING(zeus,Settings_enhanceZenContextMenu_DisplayName), ELSTRING(zeus,Settings_enhanceZenContextMenu_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(zeus,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

// AA fire control

[
    QEGVAR(aafc,defaultInitialMode), "LIST",
    [ELSTRING(aafc,Settings_defaultInitialMode_DisplayName), ELSTRING(aafc,Settings_defaultInitialMode_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    [
        ["FC_DEFAULT_ANGRY", "FC_DEFAULT_CALM"],
        [ELSTRING(aafc,Settings_defaultInitialMode_Angry), ELSTRING(aafc,Settings_defaultInitialMode_Calm)],
        0
    ], // values
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,autoReload), "CHECKBOX",
    [ELSTRING(aafc,Settings_autoReload_DisplayName), ELSTRING(aafc,Settings_autoReload_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,reportAirOnly), "CHECKBOX",
    [ELSTRING(aafc,Settings_reportAirOnly_DisplayName), ELSTRING(aafc,Settings_reportAirOnly_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,sideChatContact), "CHECKBOX",
    [ELSTRING(aafc,Settings_sideChatContact_DisplayName), ELSTRING(aafc,Settings_sideChatContact_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,sideChatFired), "CHECKBOX",
    [ELSTRING(aafc,Settings_sideChatFired_DisplayName), ELSTRING(aafc,Settings_sideChatFired_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(zeus,moduleMSE_useAI), "CHECKBOX",
    [ELSTRING(zeus,Settings_moduleMSE_useAI_DisplayName), ELSTRING(zeus,Settings_moduleMSE_useAI_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(zeus,moduleMSE_transferHC), "CHECKBOX",
    [ELSTRING(zeus,Settings_moduleMSE_transferHC_DisplayName), ELSTRING(zeus,Settings_moduleMSE_transferHC_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// Loadout

[
    QEGVAR(loadout,unloadWheels), "CHECKBOX",
    [ELSTRING(loadout,Settings_unloadWheels_DisplayName), ELSTRING(loadout,Settings_unloadWheels_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(loadout,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(loadout,requireFlagProximity), "CHECKBOX",
    [ELSTRING(loadout,Settings_requireFlagProximity_DisplayName), ELSTRING(loadout,Settings_requireFlagProximity_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(loadout,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(loadout,flagLoadoutRadius), "SLIDER",
    [ELSTRING(loadout,Settings_flagLoadoutRadius_DisplayName), ELSTRING(loadout,Settings_flagLoadoutRadius_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(loadout,Settings_Category_DisplayName)],
    [10, 500, 25, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// Intel

[
    QEGVAR(menu,findIntelAllSL), "CHECKBOX",
    [ELSTRING(menu,Settings_findIntelAllSL_DisplayName), ELSTRING(menu,Settings_findIntelAllSL_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryIntel_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,findIntelPreciseMarker), "CHECKBOX",
    [ELSTRING(menu,Settings_findIntelPreciseMarker_DisplayName), ELSTRING(menu,Settings_findIntelPreciseMarker_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryIntel_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,findIntelRadius), "SLIDER",
    [ELSTRING(menu,Settings_findIntelRadius_DisplayName), ELSTRING(menu,Settings_findIntelRadius_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryIntel_DisplayName)],
    [50, 2500, 150, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,findIntelMarkerTTL), "SLIDER",
    [ELSTRING(menu,Settings_findIntelMarkerTTL_DisplayName), ELSTRING(menu,Settings_findIntelMarkerTTL_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryIntel_DisplayName)],
    [30, 1800, 600, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,findIntelUseLargeFlags), "CHECKBOX",
    [ELSTRING(menu,Settings_findIntelLargeFlags_DisplayName), ELSTRING(menu,Settings_findIntelLargeFlags_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryIntel_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;
