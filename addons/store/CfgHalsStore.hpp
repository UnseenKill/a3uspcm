#include "\x\A3A\addons\hals\Addons\store\config.hpp"

class A3U {
    class traderAddons {
        class addons_base;
        class addons_a3uspcm: addons_base {
            addons[] = {"a3uspcm_main"};
            weapons = "weapons_a3uspcm";
        };

        class traderWeapons {
            class weapons_base;
            class weapons_a3uspcm: weapons_base {
                prefix = "a3uspcm_stock";
            };
        };
    };
};

class CfgHALsAddons {
    class CfgHALsStore {
        class categories {
            class miscA3USPCM {
                displayName = __EVAL(formatText ["%1 %2", "A3USPCM", localize "STR_A3AU_misc"]);
    			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa";

                ITEM(EGVAR(assets,40mm_EMP),75,PN_STOCK)
                ITEM(EGVAR(assets,Grenade_EMP),275,PN_STOCK)
                ITEM(EGVAR(despawnbeacon,PackedBeacon),750,PN_STOCK)
                ITEM(EGVAR(markers,PermanentMarker),25,PN_STOCK)
                ITEM(EGVAR(advanced_ai_orders,ItemRadio),650,PN_STOCK)
            };
        };

        class stores {
            class a3uspcm_stock {
                displayName = "$STR_ARMS_DEALER_STORE";
                categories[] = {
                    "miscA3USPCM"
                };
            };
        };
    };
};
