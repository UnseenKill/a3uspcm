#include "\x\A3A\addons\hals\Addons\store\config.hpp"

class A3U {
    class traderAddons {
        class addons_base;
        class addons_ace3: addons_base {
            addons[] = {"ace_irlight"};
            weapons = "weapons_ace3";
        };

        class traderWeapons {
            class weapons_base;
            class weapons_ace3: weapons_base {
                prefix = "ace3_stock";
            };
        };
    };
};

class CfgHALsAddons {
    class CfgHALsStore {
        class categories {
            class pointersACE3 {
                displayName = __EVAL(formatText ["%1 %2 %3 %4", "ACE3", localize "STR_A3AU_pointers", localize "STR_A3AU_and", localize "STR_A3AU_flashlights"]);
                picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemAcc_ca.paa";

                ITEM(ACE_DBAL_A3_Green,50,PN_STOCK)
                ITEM(ACE_DBAL_A3_Red,50,PN_STOCK)
            };
        };

        class stores {
            class ace3_stock {
                displayName = "$STR_ARMS_DEALER_STORE";
                categories[] = {
                    "pointersACE3"
                };
            };
            class rf {
                categories[] += {"magazinesSpecialRF"};
            };
        };
    };
};
