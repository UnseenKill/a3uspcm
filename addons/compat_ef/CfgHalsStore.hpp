#include "\z\a3uspcm\addons\store\script_macros.hpp"

class A3U {
    class traderAddons {
        class traderVehicles {
            class vehicles_ef {
                class DOUBLES(PREFIX,I_T_UAV_03_dynamicLoadout_F) {
                    price = 27490;
                    type = "UAV";
                    condition = QUOTE([[ARR_2(QQUOTE(airports),1)]] call A3U_fnc_hasRequirements && [[ARR_2(QQUOTE(factories),1)]] call A3U_fnc_hasRequirements);
                };
            };
        };
    };
};
