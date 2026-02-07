#include "\a3\ui_f\hpp\defineDIKCodes.inc"

class PREFIX {
    class ADDON {
        class Menu {
            class ItemBase {
                itemName = "";
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

                    class Pull360: ItemBase {
                        itemName = CSTRING(Menu_OrdersSecurity_Item_Pull360_DisplayName);
                        assignedKey[] = {DIK_1};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_PULL360)] call CBA_fnc_localEvent);
                        isActive = QUOTE(NotEmpty + NotEmptyRedTeam);
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
                };

                class Advance: SubmenuBase {
                    displayName = CSTRING(Menu_OrdersAdvance_DisplayName);
                    assignedKey[] = {DIK_2};
                    yesHemttThisStringtableKeyIsUsed = CSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName);

                    class Forward: ItemBase {
                        itemName = CSTRING(Menu_OrdersAdvance_Item_AdvanceForward_DisplayName);
                        assignedKey[] = {};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,_pos)])] call CBA_fnc_localEvent);
                        isActive = QUOTE((NotEmpty + NotEmptyRedTeam) * cursorOnGround);
                        iconPath = "\A3\ui_f\data\IGUI\Cfg\Cursors\waypointMark_ca.paa";
                    };

                    class Forward50: ItemBase {
                        itemName = __EVAL(formatText [LLSTRING(Menu_OrdersAdvance_Item_AdvanceForwardMeters_DisplayName), 50]);
                        assignedKey[] = {DIK_1};
                        expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_ADVANCE_FORWARD),[ARR_2(player,50)])] call CBA_fnc_localEvent);
                        isActive = QUOTE(NotEmpty + NotEmptyRedTeam);
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
                    itemName = CSTRING(Menu_OrdersSAD_DisplayName);
                    assignedKey[] = {DIK_3};
                    expression = QUOTE([ARR_2(QUOTE(CBA_EVENT_SEARCH_AND_DESTROY),[ARR_2(player,_pos)])] call CBA_fnc_localEvent);
                    isActive = QUOTE((NotEmpty + NotEmptyRedTeam) * cursorOnGround);
                    iconPath = "\a3\ui_f\data\map\markers\military\warning_ca.paa";
                };

                class SADRunning: SubmenuBase {
                    displayName = __EVAL(formatText["%1...", LLSTRING(Menu_OrdersSAD_DisplayName)]);
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
                    isActive = QUOTE(NotEmpty);
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
                        ITEM_DISTANCE(DIK_5,40);
                        ITEM_DISTANCE(DIK_6,50);
                        #undef ITEM_DISTANCE
                    };
                };
            };
        };
    };
};
