class CfgWeapons {
    class Launcher;
    class Launcher_Base_F: Launcher {
        class WeaponSlotsInfo;
    };

    class GVAR(mortar_60mm_RF_carry): Launcher_Base_F {
        displayName = "Folded Commando 60mm Mortar Carry";
        editorPreview = "\lxRF\editorpreviews_rf\Data\CfgVehicles\B_CommandoMortar_RF.jpg";
        hiddenSelections[] = {"Camo"};
        hiddenSelectionsTextures[] = {"\A3\weapons_f\ammoboxes\bags\data\backpack_tortila_blk_co.paa"};
        model = "\A3\weapons_f\Ammoboxes\bags\Backpack_Tortila.p3d";

        scope = 2;
        modes[] = {};
        picture = "\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa";

        class ACE_CSW {
            type = "weapon";
            deployTime = 4;
            pickupTime = 8;

            class assembleTo {
                ace_csw_m3Tripod = "B_CommandoMortar_RF";
            };
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            mass = 640;

            class MuzzleSlot {
                iconScale = 0.1;
            };
        };
    };

    class mortar_82mm_RF {
        class Single1;
        class Burst1;
    };

    class GVAR(mortar_60mm_RF_proxy): mortar_82mm_RF {
        magazines[] = {
            QGVAR(8Rnd_60mm_Mo_shells_RF),
            QGVAR(8Rnd_60mm_Mo_Flare_white),
            QGVAR(8Rnd_60mm_Mo_Flare_white_illumination),
            QGVAR(8Rnd_60mm_Mo_Smoke_white),
            QGVAR(8Rnd_60mm_Mo_guided),
            QGVAR(8Rnd_60mm_Mo_LG)
        };

        magazineReloadTime = 0.5;
        reloadTime = 0.5;

        class Single1: Single1 {
            reloadTime = 0.5;
        };
        class Burst1: Burst1 {
            reloadTime = 0.5;
        };
    };
};
