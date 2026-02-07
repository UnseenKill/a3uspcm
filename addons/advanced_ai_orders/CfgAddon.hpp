#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#undef true
#undef false

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
            };

            class Definitions {
                class Security: SubmenuBase {
                    displayName = CSTRING(Menu_Security_DisplayName);
                    assignedKey[] = {DIK_1};

                    class Pull360: ItemBase {
                        itemName = CSTRING(Menu_Security_Item_Pull360_DisplayName);
                        assignedKey[] = {DIK_1};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_PULL360)] call CBA_fnc_localEvent);
                        isActive = QUOTE(NotEmpty);
                    };

                    class GuardFront: Pull360 {
                        itemName = CSTRING(Menu_Security_Item_GuardFront_DisplayName);
                        assignedKey[] = {DIK_2};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_GUARD_FRONT)] call CBA_fnc_localEvent);
                    };

                    class GuardRear: Pull360 {
                        itemName = CSTRING(Menu_Security_Item_GuardRear_DisplayName);
                        assignedKey[] = {DIK_3};
                        expression = QUOTE([QUOTE(CBA_EVENT_SECURITY_GUARD_REAR)] call CBA_fnc_localEvent);
                    };
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
