class A3U {
    class forbiddenItems {
        class forbidden_limited_base;

        class GVAR(ForbiddenItemsBase): forbidden_limited_base {
            addons[] = {"a3uspcm_assets"};
        };

        class EGVAR(assets,DecryptKeyPack_B): GVAR(ForbiddenItemsBase) {};
        class EGVAR(assets,DecryptKeyPack_O): GVAR(ForbiddenItemsBase) {};
        class EGVAR(assets,DecryptKeyRefuse): GVAR(ForbiddenItemsBase) {};
        class EGVAR(assets,DecryptKeyRefuseReread): GVAR(ForbiddenItemsBase) {};
        class EGVAR(assets,DecryptKeySingle_B): GVAR(ForbiddenItemsBase) {};
        class EGVAR(assets,DecryptKeySingle_O): GVAR(ForbiddenItemsBase) {};
    };

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

                A3U_STORE_ITEM(EGVAR(assets,40mm_EMP),75,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(EGVAR(assets,Grenade_EMP),275,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(EGVAR(despawnbeacon,PackedBeacon),750,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(EGVAR(markers,PermanentMarker),25,A3U_STORE_PN_STOCK);
                A3U_STORE_ITEM(EGVAR(assets,DecryptKeyPack_B),6800,3);
                A3U_STORE_ITEM(EGVAR(assets,DecryptKeySingle_B),875,20);
                A3U_STORE_ITEM(EGVAR(assets,DecryptKeyPack_O),6800,3);
                A3U_STORE_ITEM(EGVAR(assets,DecryptKeySingle_O),875,20);
                A3U_STORE_ITEM(EGVAR(advanced_ai_orders,ItemRadio),650,A3U_STORE_PN_STOCK);
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
