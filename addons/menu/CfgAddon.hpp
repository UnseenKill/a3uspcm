class GVAR(Config) {
    class Diary {
        class Miscellaneous {
            caption = CSTRING(DiaryMiscellaneousCaption);
            text = CSTRING(DiaryMiscellaneousText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\repair_ca.paa);

            class AddTeamZeus {
                caption = CSTRING(Miscellaneous_AddTeamZeusCaption);
                text = CSTRING(Miscellaneous_AddTeamZeusText);
                action = QFUNCMAIN(miscAddTeamZeus);
                cmShortcut = 1;
                closeDiary = 1;
            };

            class Uncompromise {
                caption = CSTRING(Miscellaneous_UncompromiseCaption);
                text = CSTRING(Miscellaneous_UncompromiseText);
                action = QFUNCMAIN(miscUncompromise);
                cmShortcut = 1;
            };

            class MakeLootBox {
                caption = CSTRING(Miscellaneous_MakeLootBoxCaption);
                text = CSTRING(Miscellaneous_MakeLootBoxText);
                action = QFUNCMAIN(miscMakeLootBox);
                closeDiary = 1;
            };

            class PlaceBeacon {
                caption = CSTRING(Miscellaneous_PlaceBeaconCaption);
                text = CSTRING(Miscellaneous_PlaceBeaconText);
                action = QFUNCMAIN(miscPlaceBeacon);
                closeDiary = 1;
            };

            class RepairBuildings {
                caption = CSTRING(Miscellaneous_RepairBuildingsCaption);
                text = CSTRING(Miscellaneous_RepairBuildingsText);
                action = QFUNCMAIN(miscRepairBuildings);
            };

            class FindIntel {
                caption = CSTRING(Miscellaneous_FindIntelCaption);
                text = CSTRING(Miscellaneous_FindIntelText);
                action = QFUNCMAIN(miscFindIntel);
                cmShortcut = 1;

                separator = 1;

                class Intel {
                    chemlights[] = {"Chemlight_blue","Chemlight_green","Chemlight_red","Chemlight_yellow"};
                    flags[] = {"ace_marker_flags_red","ace_flags_carrier_red"};
                    laptops[] = {"Land_laptop_03_closed_black_F", "Land_laptop_03_closed_sand_F", "Land_laptop_03_closed_olive_F"};
                };
            };

            class FixAirDropVehicles {
                caption = CSTRING(Miscellaneous_FixAirDropVehiclesCaption);
                text = CSTRING(Miscellaneous_FixAirDropVehiclesText);
                action = QFUNCMAIN(miscFixAirDropVehicles);
            };

            class FixAirSupportVehicles {
                caption = CSTRING(Miscellaneous_FixAirSupportVehiclesCaption);
                text = CSTRING(Miscellaneous_FixAirSupportVehiclesText);
                action = QFUNCMAIN(miscFixAirSupportVehicles);
            };

            class FixVoices {
                caption = CSTRING(Miscellaneous_FixVoicesCaption);
                text = CSTRING(Miscellaneous_FixVoicesText);
                action = QFUNCMAIN(miscFixVoices);

                separator = 1;
            };

            class AddToBuildables {
                caption = CSTRING(Miscellaneous_AddToBuildablesCaption);
                text = CSTRING(Miscellaneous_AddToBuildablesText);
                action = QFUNCMAIN(miscAddToBuildables);
                closeDiary = 1;
            };

            class AirAccessAnywhere {
                caption = CSTRING(Miscellaneous_AirAccessAnywhereCaption);
                text = CSTRING(Miscellaneous_AirAccessAnywhereText);
                action = QFUNCMAIN(miscAirAccessAnywhere);
                closeDiary = 1;
            };

            class ShowRoadblocks {
                caption = CSTRING(Miscellaneous_ShowRoadblocksCaption);
                text = CSTRING(Miscellaneous_ShowRoadblocksText);
                action = QFUNCMAIN(miscShowRoadblocks);
            };
        };

        class AAFireControl {
            caption = CSTRING(DiaryAAFireControlCaption);
            text = CSTRING(DiaryAAFireControlText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\getingunner_ca.paa);
            initCallback = QEFUNC(aafc,onMenuInit);
            updateCallback = QEFUNC(aafc,onMenuUpdate);

            class AllFire {
                caption = CSTRING(AAFireControl_AllFireCaption);
                text = CSTRING(AAFireControl_AllFireText);
                action = QEFUNC(aafc,toggleROEAll);
                params = QUOTE(openFire);
            };

            class AllHold {
                caption = CSTRING(AAFireControl_AllHoldCaption);
                text = CSTRING(AAFireControl_AllHoldText);
                action = QEFUNC(aafc,toggleROEAll);
                params = QUOTE(holdFire);
            };
        };

        class Teleport {
            caption = CSTRING(DiaryTeleportCaption);
            text = CSTRING(DiaryTeleportText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\open_door_ca.paa);

            class TeleportPlayer {
                caption = CSTRING(Teleport_TeleportPlayerCaption);
                text = CSTRING(Teleport_TeleportPlayerText);
                action = QFUNCMAIN(teleportPlayer);
                cmShortcut = 1;
            };

            class TeleportStragglers {
                caption = CSTRING(Teleport_TeleportStragglersCaption);
                text = CSTRING(Teleport_TeleportStragglersText);
                action = QFUNCMAIN(teleportStragglers);
            };

            class TeleportArsenalBox {
                caption = CSTRING(Teleport_TeleportArsenalBoxCaption);
                text = CSTRING(Teleport_TeleportArsenalBoxText);
                action = QFUNCMAIN(teleportRebelObject);
                params = QUOTE(boxX);
                closeDiary = 1;
            };

            class TeleportVehicleBox {
                caption = CSTRING(Teleport_TeleportVehicleBoxCaption);
                text = CSTRING(Teleport_TeleportVehicleBoxText);
                action = QFUNCMAIN(teleportRebelObject);
                params = QUOTE(vehicleBox);
                closeDiary = 1;
            };

            class TeleportMap {
                caption = CSTRING(Teleport_TeleportMapCaption);
                text = CSTRING(Teleport_TeleportMapText);
                action = QFUNCMAIN(teleportRebelObject);
                params = QUOTE(mapX);
                closeDiary = 1;
            };

            class TeleportFlag {
                caption = CSTRING(Teleport_TeleportFlagCaption);
                text = CSTRING(Teleport_TeleportFlagText);
                action = QFUNCMAIN(teleportRebelFlag);
                closeDiary = 1;
            };
        };

        class Trader {
            caption = CSTRING(DiaryTraderCaption);
            text = CSTRING(DiaryTraderText);
            image = QUOTE(\z\a3uspcm\addons\menu\ui\trader_ca.paa);

            class Move {
                caption = CSTRING(Trader_MoveCaption);
                text = CSTRING(Trader_MoveText);
                action = QFUNC(traderMove);
            };
        };

        class Recruitment {
            caption = CSTRING(DiaryRecruitmentCaption);
            text = CSTRING(DiaryRecruitmentText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\getincommander_ca.paa);

            class LaunchAGM {
                caption = CSTRING(Recruitment_LaunchAGMCaption);
                text = CSTRING(Recruitment_LaunchAGMText);
                action = QFUNCMAIN(recruitLaunchAGM);
                closeDiary = 1;
            };

            class RenameHC {
                caption = CSTRING(Recruitment_RenameHCCaption);
                text = CSTRING(Recruitment_RenameHCText);
                action = QFUNCMAIN(recruitRenameHC);
                separator = 1;
            };

            class Rifleman {
                caption = "$STR_antistasi_dialogs_unit_recruit_rifleman_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitRifle);
            };

            class Grenadier {
                caption = "$STR_antistasi_dialogs_unit_recruit_grenadier_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitGL);
            };

            class AutoRifleman {
                caption = "$STR_antistasi_dialogs_unit_recruit_mg_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitMG);
            };

            class Marksman {
                caption = "$STR_antistasi_dialogs_unit_recruit_marksman_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitSniper);
            };

            class LightAT {
                caption = "$STR_antistasi_dialogs_unit_recruit_antitank_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitLAT);
            };

            class HeavyAT {
                caption = "$STR_antistasi_dialogs_unit_recruit_atmissile_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitAT);
            };

            class HeavyAA {
                caption = "$STR_antistasi_dialogs_unit_recruit_aamissile_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitAA);
            };

            class Medic {
                caption = "$STR_antistasi_dialogs_unit_recruit_medic_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitMedic);
            };

            class Engineer {
                caption = "$STR_antistasi_dialogs_unit_recruit_engineer_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitEng);
            };

            class ExplosiveSpecialist {
                caption = "$STR_antistasi_dialogs_unit_recruit_explosive_text";
                action = QFUNCMAIN(recruitForPlayer);
                params = QUOTE(unitExp);
            };
        };

        class Resources {
            caption = CSTRING(DiaryResourcesCaption);
            text = CSTRING(DiaryResourcesText);
            image = QUOTE(\z\a3uspcm\addons\menu\ui\money_ca.paa);

            class AddPlayerMoney {
                caption = CSTRING(Resources_AddPlayerMoneyCaption);
                action = QFUNCMAIN(resourcesAddPlayerMoney);
            };

            class AddFactionMoney {
                caption = CSTRING(Resources_AddFactionMoneyCaption);
                action = QFUNCMAIN(resourcesAddFactionMoney);
            };

            class AddHR {
                caption = CSTRING(Resources_AddHRCaption);
                action = QFUNCMAIN(resourcesAddHR);
            };

            class Transfer {
                caption = CSTRING(Resources_TransferCaption);
                text = CSTRING(Resources_TransferText);
                action = QFUNC(resourcesTransfer);
            };

            class ShowResourcesAll {
                caption = CSTRING(Resources_ShowResourcesAllCaption);
                text = CSTRING(Resources_ShowResourcesAllText);
                action = QFUNCMAIN(resourcesShowAll);
            };
        };

        class Unlocks {
            caption = CSTRING(DiaryUnlocksCaption);
            text = CSTRING(DiaryUnlocksText);
            image = QUOTE(\z\a3uspcm\addons\menu\ui\unlock_ca.paa);

            class AcePainkillers {
                caption = CSTRING(Unlocks_AcePainkillersCaption);
                action = QFUNCMAIN(unlockAcePainkillers);
            };

            class AceEHP {
                caption = CSTRING(Unlocks_AceEHPCaption);
                action = QFUNCMAIN(unlockAceEHP);
            };

            class BreachingChargeAPCs {
                caption = CSTRING(Unlocks_BreachingChargeAPCsCaption);
                action = QFUNCMAIN(unlockBreachingChargeAPCs);
            };

            class BreachingChargeTanks {
                caption = CSTRING(Unlocks_BreachingChargeTanksCaption);
                action = QFUNCMAIN(unlockBreachingChargeTanks);
            };

            class PermanentMarker {
                caption = CSTRING(Unlocks_PermanentMarkerCaption);
                action = QFUNCMAIN(unlockPermanentMarker);
                separator = 1;
            };

            class Loadout {
                caption = CSTRING(Unlocks_LoadoutCaption);
                text = CSTRING(Unlocks_LoadoutText);
                action = QFUNCMAIN(unlockLoadout);
                separator = 1;
            };

            class SortArsenal {
                caption = CSTRING(Unlocks_SortArsenalCaption);
                text = CSTRING(Unlocks_SortArsenalText);
                action = QFUNC(unlockSortArsenal);
            };
        };

        class Healing {
            caption = CSTRING(DiaryHealingCaption);
            text = CSTRING(DiaryHealingText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\heal_ca.paa);

            class HealPlayer {
                caption = CSTRING(Healing_HealPlayerCaption);
                text = CSTRING(Healing_HealPlayerText);
                action = QFUNCMAIN(healPlayer);
            };

            class HealGroup {
                caption = CSTRING(Healing_HealGroupCaption);
                text = CSTRING(Healing_HealGroupText);
                action = QFUNCMAIN(healGroup);
            };
        };
    };
};
