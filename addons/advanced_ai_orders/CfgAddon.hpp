class PREFIX {
    class ADDON {
        class Menu {
            class ItemBase {
                itemName = "";
                assignedKey[] = {};
                command = -5;
                expression = QUOTE(nil);
                isActive = QUOTE(1);
                isVisible = QUOTE(1);
                iconPath = "";
            };

            class SeparatorBase {
                command = -1;
            };

            class SubmenuBase {
                displayName = "";
                subMenu = 1;
                assignedKey[] = {};
                command = -5;
                isActive = QUOTE(1);
                isVisible = QUOTE(1);
            };

            class Security: SubmenuBase {
                displayName = CSTRING(Menu_Security_DisplayName);
                assignedKey[] = {2};

                class Pull360: ItemBase {
                    itemName = CSTRING(Menu_Security_Item_Pull360_DisplayName);
                    assignedKey[] = {2};
                    expression = QUOTE(call FUNC(securityPull360));
                    isActive = QUOTE(NotEmpty);
                };
            };

            class Unstick: ItemBase {
                itemName = ECSTRING(menu,Miscellaneous_UnstickCaption);
                assignedKey[] = {10};
                expression = QUOTE(call FUNCMAIN(miscUnstick));
                isActive = QUOTE(NotEmpty);
                iconPath = "\a3\ui_f\data\map\markers\military\warning_ca.paa";
            };

            class Sep0: SeparatorBase {};

            class Settings: SubmenuBase {
                displayName = CSTRING(Menu_Security_Item_Settings_DisplayName);

                class SecurityDistance: SubmenuBase {
                    displayName = CSTRING(Menu_Security_Item_Settings_Distance_DisplayName);
                    #define ITEM_DISTANCE(distance) \
                        class SecurityDistance##distance##m: ItemBase { \
                            itemName = QUOTE(distance meters); \
                            expression = QUOTE([distance] call FUNC(securitySetDistance)); \
                        }

                    ITEM_DISTANCE(5);
                    ITEM_DISTANCE(10);
                    ITEM_DISTANCE(20);
                    ITEM_DISTANCE(30);
                    ITEM_DISTANCE(40);
                    ITEM_DISTANCE(50);
                };
            };
        };
    };
};
