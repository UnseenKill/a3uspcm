#include "\x\A3A\addons\hals\Addons\store\config.hpp"

class CfgHALsAddons {
    class CfgHALsStore {
        class stores {
            class rf {
                categories[] += {"magazinesCSW_RF"};
            };
        };

        class categories {
            class magazinesCSW_RF {
    			displayName = __EVAL(formatText ["%1 %2", localize "STR_A3AU_RF", LLSTRING(CSW_Store_Category)]);
    			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
                thisStringIsInUseHEMTT = CSTRING(CSW_Store_Category);

                ITEM(GVAR(2Rnd_60mm_Mo_Flare_white_RF),50,MAGAZINE_STOCK)
                ITEM(GVAR(2Rnd_60mm_Mo_Smoke_white_RF),50,MAGAZINE_STOCK)
                ITEM(GVAR(4Rnd_60mm_Mo_Flare_white_RF),100,MAGAZINE_STOCK)
                ITEM(GVAR(4Rnd_60mm_Mo_guided_RF),400,MAGAZINE_STOCK)
                ITEM(GVAR(4Rnd_60mm_Mo_LG_RF),375,MAGAZINE_STOCK)
                ITEM(GVAR(4Rnd_60mm_Mo_Smoke_white_RF),100,MAGAZINE_STOCK)
                ITEM(GVAR(4Rnd_60mm_Mo_shells_RF),250,MAGAZINE_STOCK)
                ITEM(GVAR(8Rnd_60mm_Mo_shells_RF),500,MAGAZINE_STOCK)
                ITEM(GVAR(8Rnd_60mm_Mo_LG_RF),750,MAGAZINE_STOCK)
                ITEM(GVAR(8Rnd_60mm_Mo_guided_RF),800,MAGAZINE_STOCK)
            };
        };
    };
};
