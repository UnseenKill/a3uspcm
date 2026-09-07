class A3U {
    class traderAddons {
        class traderVehicles {
            class vehicles_ef {
                class I_WNZ_MQ10 {
                    price = 36000;
                    type = "UAV";
                    condition = QUOTE([[ARR_2(QQUOTE(airports),1)]] call A3U_fnc_hasRequirements && {[[ARR_2(QQUOTE(factories),1)]] call A3U_fnc_hasRequirements});
                };

                class I_WNZ_MQ11: I_WNZ_MQ10 {
                    price = 38000;
                };

                class I_WNZ_MQ13: I_WNZ_MQ10 {
                    price = 42000;
                };

                class I_WNZ_MQ14: I_WNZ_MQ10 {
                    price = 50000;
                };

                class I_WNZ_MQ15: I_WNZ_MQ10 {
                    price = 66000;
                };
            };
        };
    };
};
