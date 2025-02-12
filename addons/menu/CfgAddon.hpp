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
            };

            class MakeLootBox {
                caption = CSTRING(Miscellaneous_MakeLootBoxCaption);
                text = CSTRING(Miscellaneous_MakeLootBoxText);
                action = QFUNCMAIN(miscMakeLootBox);
            };

            class RepairBuildings {
                caption = CSTRING(Miscellaneous_RepairBuildingsCaption);
                text = CSTRING(Miscellaneous_RepairBuildingsText);
                action = QFUNCMAIN(miscRepairBuildings);
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
        };

        class Teleport {
            caption = CSTRING(DiaryTeleportCaption);
            text = CSTRING(DiaryTeleportText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\open_door_ca.paa);

            class TeleportPlayer {
                caption = CSTRING(Teleport_TeleportPlayerCaption);
                text = CSTRING(Teleport_TeleportPlayerText);
                action = QFUNCMAIN(teleportPlayer);
            };

            class TeleportStragglers {
                caption = CSTRING(Teleport_TeleportStragglersCaption);
                text = CSTRING(Teleport_TeleportStragglersText);
                action = QFUNCMAIN(teleportStragglers);
            };
        };

        class Recruitment {
            caption = CSTRING(DiaryRecruitmentCaption);
            text = CSTRING(DiaryRecruitmentText);
            image = QUOTE(a3\ui_f\data\igui\cfg\actions\getincommander_ca.paa);

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
