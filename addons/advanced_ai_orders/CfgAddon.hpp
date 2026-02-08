#include "\a3\ui_f\hpp\defineDIKCodes.inc"

class PREFIX {
    class ADDON {
        class Menu {
            yesHemttThoseStringtableKeysAreUsed[] = {
                CSTRING(Menu_StartTasking_DisplayName),
                CSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName)
            };

            class ItemBase {
                itemName = "";
                itemNameFrom = "";
                assignedKey[] = {};
                command = -5;
                expression = QUOTE(nil);
                conditionActive = QUOTE(true);
                conditionVisible = QUOTE(true);
                isActive = QUOTE(1);
                isVisible = QUOTE(1);
                iconPath = "";
                selected = "";
                updateAfterExecution = 0;
            };

            class SeparatorBase {
                command = -1;
            };

            class SubmenuBase: ItemBase {
                displayName = "";
                subMenu = 1;
                subMenuFrom = "";
            };

            class Definitions {
                class Security: SubmenuBase {
                    displayName = CSTRING(Menu_OrdersSecurity_DisplayName);
                    assignedKey[] = {DIK_1};
                    isActive = QUOTE(IsLeader * (1 - IsAlone) * (NotEmpty + NotEmptyRedTeam));

                    class Pull360: ItemBase {
                        itemName = CSTRING(Menu_OrdersSecurity_Item_Pull360_DisplayName);
                        assignedKey[] = {DIK_1};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_PULL360)] call CBA_fnc_localEvent);
                    };

                    class GuardFront: Pull360 {
                        itemName = CSTRING(Menu_OrdersSecurity_Item_GuardFront_DisplayName);
                        assignedKey[] = {DIK_2};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_GUARD_FRONT)] call CBA_fnc_localEvent);
                    };

                    class GuardRear: Pull360 {
                        itemName = CSTRING(Menu_OrdersSecurity_Item_GuardRear_DisplayName);
                        assignedKey[] = {DIK_3};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_GUARD_REAR)] call CBA_fnc_localEvent);
                    };

                    class Sep0: SeparatorBase {
                        conditionVisible = QUOTE(!isNil QQGVAR(securityReference));
                    };

                    class CycleReference: ItemBase {
                        itemNameFrom = QUOTE(call FUNC(getSecurityReferenceMenuItemName));
                        assignedKey[] = {DIK_5};
                        conditionVisible = QUOTE(!isNil QQGVAR(securityReference));
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_CYCLE_REFERENCE),player)] call CBA_fnc_localEvent);
                        updateAfterExecution = 1;
                    };

                    class Sep1: SeparatorBase {};

                    class ReturnToPosition: ItemBase {
                        itemName = CSTRING(Menu_OrdersSecurity_Item_ReturnToPosition_DisplayName);
                        assignedKey[] = {DIK_9};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_RETURN_TO_POSITION)] call CBA_fnc_localEvent);
                        isActive = QUOTE(NotEmpty + CursorOnGroupMember);
                    };
                };

                class Advance: SubmenuBase {
                    displayName = CSTRING(Menu_OrdersAdvance_DisplayName);
                    assignedKey[] = {DIK_2};
                    isActive = QUOTE(IsLeader * (1 - IsAlone) * (NotEmpty + NotEmptyRedTeam));

                    class Forward: ItemBase {
                        itemName = CSTRING(Menu_OrdersAdvance_Item_AdvanceForward_DisplayName);
                        assignedKey[] = {};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,_pos)])] call CBA_fnc_localEvent);
                        isActive = QUOTE(cursorOnGround);
                        iconPath = "\A3\ui_f\data\IGUI\Cfg\Cursors\waypointMark_ca.paa";
                    };

                    class Forward50: ItemBase {
                        itemName = __EVAL(formatText [LLSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName), 50]);
                        assignedKey[] = {DIK_1};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,50)])] call CBA_fnc_localEvent);
                    };

                    class Forward75: Forward50 {
                        itemName = __EVAL(formatText [LLSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName), 75]);
                        assignedKey[] = {DIK_2};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,75)])] call CBA_fnc_localEvent);
                    };

                    class Forward100: Forward50 {
                        itemName = __EVAL(formatText [LLSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName), 100]);
                        assignedKey[] = {DIK_3};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,100)])] call CBA_fnc_localEvent);
                    };

                    class Forward200: Forward50 {
                        itemName = __EVAL(formatText [LLSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName), 200]);
                        assignedKey[] = {DIK_4};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,200)])] call CBA_fnc_localEvent);
                    };

                    class Sep0: SeparatorBase {};

                    class ToMe: Forward50 {
                        itemName = CSTRING(Menu_OrdersAdvance_Item_AdvanceToMe_DisplayName);
                        assignedKey[] = {DIK_0};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,player)])] call CBA_fnc_localEvent);
                    };
                };

                class SAD: ItemBase {
                    itemName = __EVAL(formatText[LLSTRING(Menu_StartTasking_DisplayName), LLSTRING(Menu_OrdersSAD_DisplayName)]);
                    assignedKey[] = {DIK_3};
                    expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_SEARCH_AND_DESTROY),[ARR_2(player,_pos)])] call CBA_fnc_localEvent);
                    isActive = QUOTE(IsLeader * (1 - IsAlone) * (NotEmpty + NotEmptyRedTeam) * cursorOnGround);
                    iconPath = "\a3\ui_f\data\map\markers\military\warning_ca.paa";
                };

                class OpsRunning: SubmenuBase {
                    displayName = CSTRING(Menu_CancelRunningOps_DisplayName);
                    assignedKey[] = {DIK_3};
                    conditionVisible = QUOTE(keys(missionNamespace getVariable[ARR_2(QQGVAR(sadMissions),createHashmap)]) isNotEqualTo []);
                    subMenuFrom = QUOTE(call FUNC(getSADMenuItems));
                };

#ifdef __A3USPCM_PRODUCTION__
    #define LAST_ASSIGNED_KEY DIK_0
#else
    #define LAST_ASSIGNED_KEY DIK_9
#endif // __A3USPCM_PRODUCTION__
                class Unstick: ItemBase {
                    itemName = ECSTRING(menu,Miscellaneous_UnstickCaption);
                    assignedKey[] = {LAST_ASSIGNED_KEY};
                    expression = QUOTE(call FUNCMAIN(miscUnstick));
                    isActive = QUOTE(NotEmpty * IsLeader * (1 - IsAlone));
                    iconPath = "\a3\ui_f\data\map\markers\military\warning_ca.paa";
                };

#ifndef __A3USPCM_PRODUCTION__
                class Debug: ItemBase {
                    itemName = "Debug";
                    assignedKey[] = {DIK_0};
                    expression = QUOTE([ARR_3(player,[],true)] call compile preprocessFileLineNumbers 'module.sqf');
                };
#endif // __A3USPCM_PRODUCTION__
                class Sep0: SeparatorBase {};

                class Settings: SubmenuBase {
                    displayName = CSTRING(Menu_Security_Item_Settings_DisplayName);
                    assignedKey[] = {DIK_S};

                    class SecurityDistance: SubmenuBase {
                        displayName = CSTRING(Menu_Security_Item_Settings_Distance_DisplayName);

                        #define ITEM_DISTANCE(keyBind,distance) \
                            class SecurityDistance##distance##m: ItemBase { \
                                assignedKey[] = {keyBind}; \
                                itemName = QUOTE(distance meters); \
                                expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_SETTINGS_SET_SECURITY_DISTANCE),distance)] call CBA_fnc_localEvent); \
                                selected = QUOTE(GVAR(securityDistance) == distance); \
                                updateAfterExecution = 1; \
                            }
                        ITEM_DISTANCE(DIK_1,5);
                        ITEM_DISTANCE(DIK_2,10);
                        ITEM_DISTANCE(DIK_3,20);
                        ITEM_DISTANCE(DIK_4,30);
                        ITEM_DISTANCE(DIK_5,50);
                        ITEM_DISTANCE(DIK_6,75);
                        #undef ITEM_DISTANCE

                        class Sep0: SeparatorBase {};

                        class SetReference: ItemBase {
                            itemName = CSTRING(Menu_Security_Item_Settings_Reference_DisplayName);
                            assignedKey[] = {DIK_9};
                            expression = QUOTE([QUOTE(CBA_EVENT_SETTINGS_SET_SECURITY_REFERENCE)] call CBA_fnc_localEvent);
                            updateAfterExecution = 1;
                            isActive = QUOTE((1 - NotEmpty) * (CursorOnVehicleCanGetIn + CursorOnGround));
                        };
                    };

                    class SAD: SubmenuBase {
                        displayName = CSTRING(Menu_OrdersSAD_DisplayName);

                        class SADSweepTime: SubmenuBase {
                            displayName = CSTRING(Menu_Security_Item_Settings_SADSweepTime_DisplayName);

                            #define ITEM_SAD_SWEEP_TIME(keyBind,llstring,time) \
                                class SADSweepTime##time##s: ItemBase { \
                                    assignedKey[] = {keyBind}; \
                                    itemName = CSTRING(llstring); \
                                    expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_SETTINGS_SET_SAD_SWEEP_TIME),time)] call CBA_fnc_localEvent); \
                                    selected = QUOTE(GVAR(sadSweepTime) == time); \
                                    updateAfterExecution = 1; \
                                }
                            ITEM_SAD_SWEEP_TIME(DIK_1,Menu_Security_Item_Settings_SADSweepTimeShort_DisplayName,10);
                            ITEM_SAD_SWEEP_TIME(DIK_2,Menu_Security_Item_Settings_SADSweepTimeNormal_DisplayName,120);
                            ITEM_SAD_SWEEP_TIME(DIK_3,Menu_Security_Item_Settings_SADSweepTimeLong_DisplayName,240);
                            #undef ITEM_SAD_SWEEP_TIME
                        };

                        class SADStagingDistance: SubmenuBase {
                            displayName = CSTRING(Menu_Security_Item_Settings_StagingDistance_DisplayName);

                            #define ITEM_SAD_STAGING_DISTANCE(keyBind,distance) \
                                class SADStagingDist##distance##m: ItemBase { \
                                    assignedKey[] = {keyBind}; \
                                    itemName = QUOTE(distance meters); \
                                    expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_SETTINGS_SET_SAD_STAGING_DISTANCE),distance)] call CBA_fnc_localEvent); \
                                    selected = QUOTE(GVAR(sadStagingDistance) == distance); \
                                    updateAfterExecution = 1; \
                                }
                            ITEM_SAD_STAGING_DISTANCE(DIK_1,20);
                            ITEM_SAD_STAGING_DISTANCE(DIK_2,50);
                            ITEM_SAD_STAGING_DISTANCE(DIK_3,100);
                            ITEM_SAD_STAGING_DISTANCE(DIK_4,150);
                            ITEM_SAD_STAGING_DISTANCE(DIK_5,200);
                            #undef ITEM_SAD_STAGING_DISTANCE
                        };

                        class SADRallyDistance: SubmenuBase {
                            displayName = CSTRING(Menu_Security_Item_Settings_RallyDistance_DisplayName);

                            #define ITEM_SAD_RALLY_DISTANCE(keyBind,distance) \
                                class SADRallyDist##distance##m: ItemBase { \
                                    assignedKey[] = {keyBind}; \
                                    itemName = QUOTE(distance meters); \
                                    expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_SETTINGS_SET_SAD_RALLY_DISTANCE),distance)] call CBA_fnc_localEvent); \
                                    selected = QUOTE(GVAR(sadRallyDistance) == distance); \
                                    updateAfterExecution = 1; \
                                }
                            ITEM_SAD_RALLY_DISTANCE(DIK_1,20);
                            ITEM_SAD_RALLY_DISTANCE(DIK_2,50);
                            ITEM_SAD_RALLY_DISTANCE(DIK_3,100);
                            ITEM_SAD_RALLY_DISTANCE(DIK_4,150);
                            ITEM_SAD_RALLY_DISTANCE(DIK_5,200);
                            #undef ITEM_SAD_RALLY_DISTANCE
                        };
                    };
                };
            };
        };
    };
};
