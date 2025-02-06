class GVAR(Config) {
    class Diary {
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
    };
};
