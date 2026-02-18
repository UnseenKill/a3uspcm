// Common

[
    QEGVAR(menu,autoFixVoices), "CHECKBOX",
    [ELSTRING(menu,Settings_autoFixVoices_DisplayName), ELSTRING(menu,Settings_autoFixVoices_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    false, // default
    false, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,emergencyInvincibilityDuration), "TIME",
    [ELSTRING(menu,Settings_emergencyInvincibilityDuration_DisplayName), ELSTRING(menu,Settings_emergencyInvincibilityDuration_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    [0, 600, 20, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,emergencyInvincibilityCooldown), "TIME",
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
    false, // global
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
    false, // global
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
    false, // global
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

[
    QEGVAR(fixes,noBuyVehicleCooldown), "CHECKBOX",
    [ELSTRING(fixes,Settings_noBuyVehicleCooldown_DisplayName), ELSTRING(fixes,Settings_noBuyVehicleCooldown_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

// Music

[
    QEGVAR(music,overrideMusic), "CHECKBOX",
    [ELSTRING(music,Settings_overrideMusic_DisplayName), ELSTRING(music,Settings_overrideMusic_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(music,showNowPlaying), "CHECKBOX",
    [ELSTRING(music,Settings_showNowPlaying_DisplayName), ELSTRING(music,Settings_showNowPlaying_DisplayName)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(music,pause), "TIME",
    [ELSTRING(music,Settings_pause_DisplayName), ELSTRING(music,Settings_pause_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    [0, 600, 90, -1], // default
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(music,volume), "SLIDER",
    [ELSTRING(music,Settings_volume_DisplayName), ELSTRING(music,Settings_volume_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(music,Settings_Category_DisplayName)],
    [0, 5, 0.5, 3], // default
    false, // global
    {
        params[["_volume",0.5,[0]]];
        2 fadeMusic _volume;
    }, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// Menu additionals

[
    QEGVAR(menu,additionalBuildablesClassList), "EDITBOX",
    [ELSTRING(menu,Settings_additionalBuildablesClassList_DisplayName), ELSTRING(menu,Settings_additionalBuildablesClassList_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryAdditionals_DisplayName)],
    '', // min,max,default,decimals
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,additionalStaticsClassList), "EDITBOX",
    [ELSTRING(menu,Settings_additionalStaticsClassList_DisplayName), ELSTRING(menu,Settings_additionalStaticsClassList_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryAdditionals_DisplayName)],
    '', // min,max,default,decimals
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,additionalVehiclesClassList), "EDITBOX",
    [ELSTRING(menu,Settings_additionalVehiclesClassList_DisplayName), ELSTRING(menu,Settings_additionalVehiclesClassList_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryAdditionals_DisplayName)],
    '', // min,max,default,decimals
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(menu,additionalUndercoverClothesClassList), "EDITBOX",
    [ELSTRING(menu,Settings_additionalUndercoverClothesClassList_DisplayName), ELSTRING(menu,Settings_additionalUndercoverClothesClassList_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(menu,Settings_CategoryAdditionals_DisplayName)],
    '', // min,max,default,decimals
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
    QEGVAR(aafc,roeCorrectionInterval), "TIME",
    [ELSTRING(aafc,Settings_roeCorrectionInterval_DisplayName), ELSTRING(aafc,Settings_roeCorrectionInterval_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    [0, 300, 25, -1], // min,max,default,decimals
    true, // global
    {}, // onchange
    true
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,trackContacts), "CHECKBOX",
    [ELSTRING(aafc,Settings_trackContacts_DisplayName), ELSTRING(aafc,Settings_trackContacts_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,contactUpdateInterval), "SLIDER",
    [ELSTRING(aafc,Settings_contactUpdateInterval_DisplayName), ELSTRING(aafc,Settings_contactUpdateInterval_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    [0.125, 10, 1.75, 2], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,contactTrackDeadInterval), "TIME",
    [ELSTRING(aafc,Settings_contactTrackDeadInterval_DisplayName), ELSTRING(aafc,Settings_contactTrackDeadInterval_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    [0, 600, 180, 0], // min,max,default,decimals
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
    QEGVAR(aafc,autoGroupIgnoreClasses), "EDITBOX",
    [ELSTRING(aafc,Settings_autoGroupIgnoreClasses_DisplayName), ELSTRING(aafc,Settings_autoGroupIgnoreClasses_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    '["TwinMortar_base_RF"]', // min,max,default,decimals
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
    QEGVAR(aafc,playContactSound), "CHECKBOX",
    [ELSTRING(aafc,Settings_playContactSound_DisplayName), ELSTRING(aafc,Settings_playContactSound_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,sideChatContact), "CHECKBOX",
    [ELSTRING(aafc,Settings_sideChatContact_DisplayName), ELSTRING(aafc,Settings_sideChatContact_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(aafc,sideChatFired), "CHECKBOX",
    [ELSTRING(aafc,Settings_sideChatFired_DisplayName), ELSTRING(aafc,Settings_sideChatFired_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(aafc,Settings_Category_DisplayName)],
    true, // default
    false, // global
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

// AAIO

[
    QEGVAR(advanced_ai_orders,requireRadioEquipped), "CHECKBOX",
    [ELSTRING(advanced_ai_orders,Settings_requireRadioEquipped_DisplayName), ELSTRING(advanced_ai_orders,Settings_requireRadioEquipped_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(advanced_ai_orders,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// EMP

[
    QEGVAR(assets,empEffectDuration), "TIME",
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
    QEGVAR(menu,findIntelMarkerTTL), "TIME",
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

// Remote trader

[
    QEGVAR(trader,remoteTraderFee), "SLIDER",
    [ELSTRING(trader,Settings_remoteTraderFee_DisplayName), ELSTRING(trader,Settings_remoteTraderFee_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(trader,Settings_CategoryTrader_DisplayName)],
    [0, 50000, 6500, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(trader,showAccessFeeHint), "CHECKBOX",
    [ELSTRING(trader,Settings_showAccessFeeHint_DisplayName), ELSTRING(trader,Settings_showAccessFeeHint_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(trader,Settings_CategoryTrader_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(trader,airDropCooldown), "TIME",
    [ELSTRING(trader,Settings_airDropCooldown_DisplayName), ELSTRING(trader,Settings_airDropCooldown_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(trader,Settings_CategoryTrader_DisplayName)],
    [0, 7200, 600], // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// Vehicles

[
    QEGVAR(vehicles,resupplyDelay), "TIME",
    [ELSTRING(vehicles,Settings_resupplyDelay_DisplayName), ELSTRING(vehicles,Settings_resupplyDelay_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(vehicles,Settings_Category_DisplayName)],
    [0, 3600, 300, 0], // min,max,default,decimals
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(vehicles,resupplyRequireEngineer), "CHECKBOX",
    [ELSTRING(vehicles,Settings_resupplyRequireEngineer_DisplayName), ELSTRING(vehicles,Settings_resupplyRequireEngineer_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(vehicles,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(vehicles,resupplyUseGarageBoxMethod), "CHECKBOX",
    [ELSTRING(vehicles,Settings_resupplyUseGarageBoxMethod_DisplayName), ELSTRING(vehicles,Settings_resupplyUseGarageBoxMethod_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(vehicles,Settings_Category_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(vehicles,seatsUseFallback), "CHECKBOX",
    [ELSTRING(vehicles,Settings_seatsUseFallback_DisplayName), ELSTRING(vehicles,Settings_seatsUseFallback_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(vehicles,Settings_Category_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(vehicles,seatsSwitchSequenceInterval), "SLIDER",
    [ELSTRING(vehicles,Settings_seatsSwitchSequenceInterval_DisplayName), ELSTRING(vehicles,Settings_seatsSwitchSequenceInterval_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(vehicles,Settings_Category_DisplayName)],
    [0, 5, 0.75, 3], // min,max,default,decimals
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(vehicles,seatsConfigSetting), "EDITBOX",
    [ELSTRING(vehicles,Settings_seatsConfigSetting_DisplayName), ELSTRING(vehicles,Settings_seatsConfigSetting_Tooltip)],
    [ELSTRING(main,Title), ELSTRING(vehicles,Settings_Category_DisplayName)],
    "[]", // default
    false, // global
    { call EFUNC(vehicles,onSeatsConfigSettingChanged) }, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

// Experimental

[
    QEGVAR(fixes,storeQuickSell), "CHECKBOX",
    [ELSTRING(fixes,Settings_storeQuickSell_DisplayName), ELSTRING(fixes,Settings_storeQuickSell_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(store,playKaching), "CHECKBOX",
    [ELSTRING(store,Settings_playKaching_DisplayName), ELSTRING(store,Settings_playKaching_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    true, // default
    false, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(store,sellDelay), "SLIDER",
    [ELSTRING(store,Settings_sellDelay_DisplayName), ELSTRING(store,Settings_sellDelay_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    [0, 1, 0.25, 3], // min,max,default,decimals
    false, // global
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
    QEGVAR(misc,addAceTrenchesToBuildings), "CHECKBOX",
    [ELSTRING(misc,Settings_addAceTrenchesToBuildings_DisplayName), ELSTRING(misc,Settings_addAceTrenchesToBuildings_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    false, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(misc,aceFortifyEnable), "CHECKBOX",
    [ELSTRING(misc,Settings_aceFortifyEnable_DisplayName), ELSTRING(misc,Settings_aceFortifyEnable_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    true, // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(misc,aceFortifyPreset), "EDITBOX",
    [ELSTRING(misc,Settings_aceFortifyPreset_DisplayName), ELSTRING(misc,Settings_aceFortifyPreset_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    'bigGreen', // default
    true, // global
    {}, // onchange
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(misc,augmentHelipads), "LIST",
    [ELSTRING(misc,Settings_augmentHelipads_DisplayName), ELSTRING(misc,Settings_augmentHelipads_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    [ // default
        ["none","pink","red","blue","green","white","yellow","custom"],
        [
            ELSTRING(misc,Settings_augmentHelipads_Type_None),
            ELSTRING(misc,Settings_augmentHelipads_Type_Pink),
            ELSTRING(misc,Settings_augmentHelipads_Type_Red),
            ELSTRING(misc,Settings_augmentHelipads_Type_Blue),
            ELSTRING(misc,Settings_augmentHelipads_Type_Green),
            ELSTRING(misc,Settings_augmentHelipads_Type_White),
            ELSTRING(misc,Settings_augmentHelipads_Type_Yellow),
            ELSTRING(misc,Settings_augmentHelipads_Type_Custom)
        ], 2
    ],
    true, // global
    {}, // onchange
    false // Needs mission restart
] call CBA_fnc_addSetting;

[
    QEGVAR(misc,augmentHelipadsCustom), "EDITBOX",
    [ELSTRING(misc,Settings_augmentHelipadsCustom_DisplayName), ELSTRING(misc,Settings_augmentHelipadsCustom_Tooltip)],
    [ELSTRING(main,Title), LSTRING(CategoryExperimental_DisplayName)],
    "", // default
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
