#include "\z\a3uspcm\addons\store\script_macros.hpp"

class A3U {
    class traderAddons {
        class addons_base;
        class addons_ctab: addons_base {
            addons[] = {"cTab"};
            weapons = "weapons_ctab";
        };

        class traderWeapons {
            class weapons_base;
            class weapons_ctab: weapons_base {
                prefix = "ctab_stock";
            };
        };
    };
};

class CfgHALsAddons {
    class CfgHALsStore {
        class categories {
            class navigationCtab {
                displayName = __EVAL(formatText ["%1 %2", "cTab", localize "STR_A3AU_gps"]);
    			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa";

                A3U_STORE_ITEM(ItemcTab,1250,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ItemAndroid,1650,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ItemMicroDAGR,1500,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(ItemcTabHCam,250,A3U_STORE_PN_STOCK);
            };
        };

        class stores {
            class ctab_stock {
                displayName = "$STR_ARMS_DEALER_STORE";
                categories[] = {
                    "navigationCtab"
                };
            };
        };
    };
};
