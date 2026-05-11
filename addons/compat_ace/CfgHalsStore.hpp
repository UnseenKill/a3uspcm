#include "\z\a3uspcm\addons\store\script_macros.hpp"

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

                A3U_STORE_ITEM(ACE_painkillers,5,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ACE_suture,5,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ACE_DBAL_A3_Green,250,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ACE_DBAL_A3_Red,250,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ACE_Fortify,250,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ACE_FortifyToken,25,100);
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
