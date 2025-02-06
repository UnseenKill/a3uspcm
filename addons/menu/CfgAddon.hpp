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
    };
};
