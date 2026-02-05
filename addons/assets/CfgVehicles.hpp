class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class ReammoBox_F;
    class SignAd_Sponsor_F;
    class ThingX;

    class GVAR(SignHelperBase) : SignAd_Sponsor_F {
        scope = 0;

        class GVAR(UserActions) {
            onObjectInit = "";

            class ActionBase {
                displayName = "";
                displayNameCode = "";
                priority = 6;
                radius = 12;
                condition = "false";
                statement = "hint 'Test Action executed!'";
                hideOnUse = 1;
                showWindow = 0;
            };
        };

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    class GVAR(SignHelperArsenal) : GVAR(SignHelperBase) {
        scope = 2;

        displayName = CSTRING(SignHelperArsenal_DisplayName);
        editorPreview = QPATHTO_T(ui\sign_helper_arsenal_preview.jpg);
        hiddenSelectionsTextures[] = {QPATHTO_T(ui\sign_helper_arsenal_co.paa)};

        class GVAR(UserActions): GVAR(UserActions) {
            class OpenArsenal: ActionBase {
                displayNameCode = QUOTE(format[ARR_2(QQUOTE(<img image='\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceArsenal_ca.paa' size='1.6' shadow='2' /> <t size='1'>%1</t>),localize QQUOTE(STR_A3_Arsenal))]);
                condition = QUOTE(alive _target && {isNull objectParent _this} && {_target distance _this < 5});
                statement = QUOTE([] call JN_fnc_arsenal_handleAction);
            };

            class VehicleInventory: ActionBase {
                displayNameCode = QUOTE(format[ARR_2(QQUOTE(<img image='\x\A3A\addons\jeroen_arsenal\Pictures\unloadvehicle.paa' size='1.6' shadow='2' /> <t size='1'>%1</t>),localize QQUOTE(STR_JNA_ACT_CONTAINER_OPEN))]);
                condition = QUOTE(alive _target && {isNull objectParent _this} && {_target distance _this < 5});
                statement = QUOTE(call FUNC(arsenalHelperOpenVehicleInventory));
            };

            class TransferToArsenal: ActionBase {
                displayNameCode = QUOTE(format[ARR_2(QQUOTE(<img image='\a3\ui_f\data\igui\cfg\simpletasks\types\container_ca.paa' size='1.6' shadow='2' /> <t size='1'>%1</t>),localize QQUOTE(STR_antistasi_actions_transfer_to_arsenal))]);
                condition = QUOTE(true);
                statement = QUOTE(call FUNC(arsenalHelperTransferToArsenal));
            };
        };
    };

    class GVAR(SignHelperGarage) : GVAR(SignHelperBase) {
        scope = 2;

        displayName = CSTRING(SignHelperGarage_DisplayName);
        editorPreview = QPATHTO_T(ui\sign_helper_garage_preview.jpg);
        hiddenSelectionsTextures[] = {QPATHTO_T(ui\sign_helper_garage_co.paa)};

        class GVAR(UserActions): GVAR(UserActions) {
            onObjectInit = QUOTE(call HR_GRG_fnc_initGarage);

            class RestoreVehicles: ActionBase {
                displayNameCode = QUOTE(format[ARR_2(QQUOTE(<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\use_ca.paa' size='1.6' shadow='2' /> <t size='1'>%1</t>),localize QQUOTE(STR_A3A_actions_restore_units))]);
                condition = QUOTE((isPlayer _this) && {!A3A_removeRestore} && {isNull objectParent _this} && {_this == _this getVariable[ARR_2('owner',objNull)]} && {side group _this == teamPlayer});
                statement = QUOTE([] call A3A_fnc_vehicleBoxRestore);
                priority = 1.25;
            };

            class BuyStuff: ActionBase {
                displayNameCode = QUOTE(format[ARR_2(QQUOTE(<img image='a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa' size='1.6' shadow='2' /> <t size='1'>%1</t>),localize QQUOTE(STR_antistasi_actions_buy_vehicle))]);
                condition = QUOTE((isPlayer _this) && {isNull objectParent _this} && {_this == _this getVariable[ARR_2('owner',objNull)]} && {side group _this == teamPlayer});
                statement = QUOTE(createDialog QQUOTE(A3A_BuyVehicleDialog));
                priority = 1.25;
            };
        };
    };

    class GVAR(SupplyBoxBase) : ReammoBox_F {
        scope = 0;

        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_canDrag = 1;

        hiddenSelections[] = {"Camo_Signs","Camo"};
        hiddenSelectionsTextures[] = {"A3\Weapons_F\Ammoboxes\data\AmmoBox_signs_CA.paa","A3\Weapons_F\Ammoboxes\data\AmmoBox_CO.paa"};
        mapSize = 1.47;

        class A3A_logistics_Cargo {
            offset[] = {0,0,0}; //the offset from the node(s) to load the cargo on too
            rotation[] = {0,1,0}; //the rotation from the vehicle model front
            size = 1; //the amount of nodes it occupies
            recoil = 0; //the recoil a weapon impacts on the vehicle when fired (per projectile)
            isWeapon = 0; //if the cargo is a weapon (needed for proper handling of mounted weapon)
            blackList[] = {}; //specific vehicles or models to blacklist from loading this weapon/cargo
        };
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
        maximumLoad = 14400;
        model = "A3\Weapons_F\Ammoboxes\AmmoVeh_F.p3d";
        slingLoadCargoMemoryPoints[] = {"SlingLoadCargo1","SlingLoadCargo2","SlingLoadCargo3","SlingLoadCargo4"};

        class A3A_logistics_Cargo: A3A_logistics_Cargo {
            offset[] = {0,0,0.81};
            rotation[] = {1,0,0};
            size = 2;
        };
    };

    class GVAR(SupplyBoxMedium) : GVAR(SupplyBoxBase) {
        scope = 2;

        ace_cargo_size = 3;

        displayName = CSTRING(SupplyBoxMedium_DisplayName);
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Box_NATO_Wps_F.jpg";
        icon = "iconCrateWpns";
        mapSize = 1.81;
        maximumLoad = 4800;
        model = "\A3\weapons_F\AmmoBoxes\WpnsBox_F.p3d";

        class A3A_logistics_Cargo: A3A_logistics_Cargo {
            offset[] = {0,0,0.17};
        };
    };

    class GVAR(SupplyBoxSmall) : GVAR(SupplyBoxBase) {
        scope = 2;

        displayName = CSTRING(SupplyBoxSmall_DisplayName);
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Box_NATO_Ammo_F.jpg";
        icon = "iconCrateAmmo";
        maximumLoad = 2400;
        model = "\A3\weapons_F\AmmoBoxes\AmmoBox_F.p3d";

        class A3A_logistics_Cargo: A3A_logistics_Cargo {
            offset[] = {0,0,0.27};
            rotation[] = {1,0,0};
        };
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
