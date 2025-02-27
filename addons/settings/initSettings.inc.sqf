// Zeus

[
    QEGVAR(zeus,moduleMSE_useAI), "CHECKBOX",
    [ELSTRING(zeus,Settings_moduleMSE_useAI_DisplayName), ELSTRING(zeus,Settings_moduleMSE_useAI_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(zeus,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

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

// Common

[
    QEGVAR(menu,recruitSkipEnemyCheck), "CHECKBOX",
    [ELSTRING(menu,Settings_recruitSkipEnemyCheck_DisplayName), ELSTRING(menu,Settings_recruitSkipEnemyCheck_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    false, // default
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
