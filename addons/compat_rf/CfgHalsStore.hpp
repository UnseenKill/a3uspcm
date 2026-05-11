#include "\z\a3uspcm\addons\store\script_macros.hpp"

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

                A3U_STORE_ITEM(GVAR(2Rnd_60mm_Mo_Flare_white_RF),50,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(2Rnd_60mm_Mo_Smoke_white_RF),50,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(4Rnd_60mm_Mo_Flare_white_RF),100,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(4Rnd_60mm_Mo_guided_RF),400,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(4Rnd_60mm_Mo_LG_RF),375,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(4Rnd_60mm_Mo_Smoke_white_RF),100,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(4Rnd_60mm_Mo_shells_RF),250,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(8Rnd_60mm_Mo_shells_RF),500,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(8Rnd_60mm_Mo_LG_RF),750,A3U_STORE_MAGAZINE_STOCK);
                A3U_STORE_ITEM(GVAR(8Rnd_60mm_Mo_guided_RF),800,A3U_STORE_MAGAZINE_STOCK);
            };
        };
    };
};
