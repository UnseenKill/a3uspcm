class CfgVehicles {
    class ReammoBox_F;
    class ThingX;

    class GVAR(SupplyBoxBase) : ReammoBox_F {
        scope = 0;

        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_canDrag = 1;

        hiddenSelections[] = {"Camo_Signs","Camo"};
        hiddenSelectionsTextures[] = {"A3\Weapons_F\Ammoboxes\data\AmmoBox_signs_CA.paa","A3\Weapons_F\Ammoboxes\data\AmmoBox_CO.paa"};
        mapSize = 1.47;
    };

    class GVAR(SupplyBoxLarge) : GVAR(SupplyBoxBase) {
        scope = 2;

        ace_cargo_size = 4;
        ace_dragging_canCarry = 0;
        ace_dragging_canDrag = 0;

        displayName = CSTRING(SupplyBoxLarge_DisplayName);
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Box_NATO_AmmoVeh_F.jpg";
        hiddenSelectionsTextures[] = {"A3\Weapons_F\Ammoboxes\data\AmmoBox_signs_CA.paa","A3\Weapons_F\Ammoboxes\data\AmmoVeh_CO.paa"};
        icon = "iconCrateVeh";
        mapSize = 1.53;
        maximumLoad = 4800;
        model = "A3\Weapons_F\Ammoboxes\AmmoVeh_F.p3d";
        slingLoadCargoMemoryPoints[] = {"SlingLoadCargo1","SlingLoadCargo2","SlingLoadCargo3","SlingLoadCargo4"};
    };

    class GVAR(SupplyBoxMedium) : GVAR(SupplyBoxBase) {
        scope = 2;

        ace_cargo_size = 3;

        displayName = CSTRING(SupplyBoxMedium_DisplayName);
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Box_NATO_Wps_F.jpg";
        icon = "iconCrateWpns";
        mapSize = 1.81;
        maximumLoad = 2400;
        model = "\A3\weapons_F\AmmoBoxes\WpnsBox_F.p3d";
    };

    class GVAR(SupplyBoxSmall) : GVAR(SupplyBoxBase) {
        scope = 2;

        displayName = CSTRING(SupplyBoxSmall_DisplayName);
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Box_NATO_Ammo_F.jpg";
        icon = "iconCrateAmmo";
        maximumLoad = 1200;
        model = "\A3\weapons_F\AmmoBoxes\AmmoBox_F.p3d";
    };

    class GVAR(DespawnSuppressionBeacon) : ThingX {
        displayName = CSTRING(SuppressionBeacon_DisplayName);
        model = "\a3\Props_F_Decade\Objectives\RuggedTerminal_01_communications_F.p3d";
        scope = 2;
        scopeCurator = 2;

        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;
        ace_cargo_noRename = 1;
        ace_cargo_blockUnloadCarry = 1;
        ace_dragging_canDrag = 1;
        ace_dragging_ignoreWeight = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_ignoreWeightCarry = 1;

        sound = "LinkTerminal_01_Standby_Loop";

        class AnimationSources {
            class Satellite_source {
                source = "user";
                initPhase = 0;
                animPeriod = 0.1;
            };
            class Terminal_source {
                source = "user";
                initPhase = 0;
                animPeriod = 0.07;
            };
            class Terminal_source_sound {
                source = "user";
                initPhase = 0;
                animPeriod = 0.07;
                sound = "LinkTerminal_01_node_1_F_Sound";
                soundposition = "Sound_node1";
            };
            class Progress_source {
                source = "user";
                initPhase = 0;
                animPeriod = 0.1;
            };
        };
    };
};
