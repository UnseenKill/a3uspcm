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

[
    QEGVAR(garrison,addActionToMapObject), "CHECKBOX",
    [ELSTRING(garrison,Settings_addActionToMapObject_DisplayName), ELSTRING(garrison,Settings_addActionToMapObject_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(garrison,allowTakeOverAnything), "CHECKBOX",
    [ELSTRING(garrison,Settings_allowTakeOverAnything_DisplayName), ELSTRING(garrison,Settings_allowTakeOverAnything_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,injectA3USPCMTab), "LIST",
    [ELSTRING(menu,Settings_injectA3USPCMTab_DisplayName), ELSTRING(menu,Settings_injectA3USPCMTab_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [ // default
        [-1, false],
        [
            ELSTRING(menu,Settings_inject_Nowhere),
            ELSTRING(menu,Settings_inject_End)
        ], 1
    ],
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,teleportGroup), "CHECKBOX",
    [ELSTRING(menu,Settings_teleportGroup_DisplayName), ELSTRING(menu,Settings_teleportGroup_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;
// Music

[
    QEGVAR(music,overrideMusic), "CHECKBOX",
    [ELSTRING(music,Settings_overrideMusic_DisplayName), ELSTRING(music,Settings_overrideMusic_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(music,showNowPlaying), "CHECKBOX",
    [ELSTRING(music,Settings_showNowPlaying_DisplayName), ELSTRING(music,Settings_showNowPlaying_DisplayName)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(music,pause), "SLIDER",
    [ELSTRING(music,Settings_pause_DisplayName), ELSTRING(music,Settings_pause_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    [0, 600, 90, -1], // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(music,volume), "SLIDER",
    [ELSTRING(music,Settings_volume_DisplayName), ELSTRING(music,Settings_volume_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    [0, 5, 0.5, 3], // default
    true, // global
    {
        params[["_volume",0.5,[0]]];
        2 fadeMusic _volume;
    }, // onchange
    false // Needs mission restart
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
    QEGVAR(aafc,aiSkill), "SLIDER",
    [ELSTRING(aafc,Settings_aiSkill_DisplayName), ELSTRING(aafc,Settings_aiSkill_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    [0, 1, 0.75, 2, true], // min,max,default,decimals,isPercentage
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,autoGroupAtStart), "CHECKBOX",
    [ELSTRING(aafc,Settings_autoGroupAtStart_DisplayName), ELSTRING(aafc,Settings_autoGroupAtStart_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,autoGroupRadius), "SLIDER",
    [ELSTRING(aafc,Settings_autoGroupRadius_DisplayName), ELSTRING(aafc,Settings_autoGroupRadius_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    [10, 1000, 200, -1], // min,max,default,decimals
    true, // global
    {}, // onchange
    true // Needs mission restart
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
    QEGVAR(loadout,aceInteractShowVehicleDumpAction), "CHECKBOX",
    [ELSTRING(loadout,Settings_aceInteractShowVehicleDumpAction_DisplayName), ELSTRING(loadout,Settings_aceInteractShowVehicleDumpAction_Tooltip)],
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

[
    QEGVAR(loadout,containerDumpContentsDelay), "SLIDER",
    [ELSTRING(loadout,Settings_containerDumpContentsDelay_DisplayName), ELSTRING(loadout,Settings_containerDumpContentsDelay_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(loadout,Settings_Category_DisplayName)],
    [0, 180, 15, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// EMP

[
    QEGVAR(assets,empEffectDuration), "SLIDER",
    [ELSTRING(assets,Settings_empEffectDuration_DisplayName), ELSTRING(assets,Settings_empEffectDuration_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(assets,Settings_Category_DisplayName)],
    [0, 3600, 300, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(assets,empEffectRangeBlackout), "SLIDER",
    [ELSTRING(assets,Settings_empEffectRangeBlackout_DisplayName), ELSTRING(assets,Settings_empEffectRangeBlackout_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(assets,Settings_Category_DisplayName)],
    [0, 1500, 300, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(assets,empEffectRangeVehicleDamage), "SLIDER",
    [ELSTRING(assets,Settings_empEffectRangeVehicleDamage_DisplayName), ELSTRING(assets,Settings_empEffectRangeVehicleDamage_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(assets,Settings_Category_DisplayName)],
    [0, 1500, 100, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(assets,empEffectLightsListEntry), "EDITBOX",
    [ELSTRING(assets,Settings_empEffectLightsList_DisplayName), ELSTRING(assets,Settings_empEffectLightsList_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(assets,Settings_Category_DisplayName)],
    "[]", // default
    true, // global
    { // onchange
        params[["_list","",[""]]];
        private _parsed = parseSimpleArray _list;

        TRACE_2("EMP lights",_this,_parsed);

        if (_parsed isEqualType []) then {
            EGVAR(assets,empEffectsLights) = [];
            _parsed apply {
                if (_x isEqualType "") then {
                    EGVAR(assets,empEffectsLights) pushBackUnique _x;
                };
            };
        };
    },
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(assets,requireVehicleEngineOn), "CHECKBOX",
    [ELSTRING(assets,Settings_requireVehicleEngineOn_DisplayName), ELSTRING(assets,Settings_requireVehicleEngineOn_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(assets,Settings_Category_DisplayName)],
    true, // default
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

// Persistent markers

[
    QEGVAR(markers,allowPersistentMarkers), "CHECKBOX",
    [ELSTRING(markers,Settings_allowPersistentMarkers_DisplayName), ELSTRING(markers,Settings_allowPersistentMarkers_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(markers,Settings_CategoryMarkers_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(markers,allowUsageFor), "LIST",
    [ELSTRING(markers,Settings_allowUsageFor_DisplayName), ELSTRING(markers,Settings_allowUsageFor_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(markers,Settings_CategoryMarkers_DisplayName)],
    [ // default
        ["theBoss","members","anyone"],
        [
            ELSTRING(markers,Settings_allowUsageFor_TheBoss),
            ELSTRING(markers,Settings_allowUsageFor_Members),
            ELSTRING(markers,Settings_allowUsageFor_Anyone)
        ], 0
    ],
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(markers,saveLimit), "SLIDER",
    [ELSTRING(markers,Settings_saveLimit_DisplayName), ELSTRING(markers,Settings_saveLimit_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(markers,Settings_CategoryMarkers_DisplayName)],
    [1, 500, 20, -1], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// Experimental

[
    QEGVAR(fixes,storeQuickSell), "CHECKBOX",
    [ELSTRING(fixes,Settings_storeQuickSell_DisplayName), ELSTRING(fixes,Settings_storeQuickSell_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(store,playKaching), "CHECKBOX",
    [ELSTRING(store,Settings_playKaching_DisplayName), ELSTRING(store,Settings_playKaching_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(store,sellDelay), "SLIDER",
    [ELSTRING(store,Settings_sellDelay_DisplayName), ELSTRING(store,Settings_sellDelay_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    [0, 1, 0.25, 3], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(store,sellForbidden), "CHECKBOX",
    [ELSTRING(store,Settings_sellForbidden_DisplayName), ELSTRING(store,Settings_sellForbidden_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(weapons,vehicleWeaponsAdditionalClasses), "EDITBOX",
    [ELSTRING(weapons,Settings_vehicleWeaponsAdditionalClasses_DisplayName), ELSTRING(weapons,Settings_vehicleWeaponsAdditionalClasses_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    '["missiles_titan"]', // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;
