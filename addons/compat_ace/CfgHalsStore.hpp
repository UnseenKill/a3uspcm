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
                displayName = __EVAL(formatText ["%1 %2", "ACE3", localize "STR_A3AU_misc"]);
    			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa";

                ITEM(ACE_painkillers,5,PN_STOCK)
                ITEM(ACE_suture,5,PN_STOCK)
                ITEM(ACE_DBAL_A3_Green,250,PN_STOCK)
                ITEM(ACE_DBAL_A3_Red,250,PN_STOCK)
                ITEM(ACE_Fortify,250,PN_STOCK)
                ITEM(ACE_FortifyToken,25,100)
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
