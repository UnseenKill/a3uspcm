class CfgVehicles {
    class ThingX;

    class ReammoBox_F : ThingX {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(DumpContents) {
                    displayName = CSTRING(DumpContents);
                    condition = QUOTE(isNil QQGVAR(A3UEUNSVL_seen) && {call FUNCMAIN(utilVehicleHasCargo)});
                    statement = QUOTE(call FUNC(containerDumpContents));
                    icon = QPATHTOEF(assets,ui\loadout-unload.paa);\
                };

                class GVAR(ArsenalUnlock) {
                    displayName = CSTRING(ArsenalUnlock);
                    condition = QUOTE(call FUNC(canUnlock));
                    statement = QUOTE(call FUNC(arsenalUnlock));
                    icon = QPATHTOEF(assets,ui\loadout-unlock.paa);\
                };

                class GVAR(ArsenalDiscard) {
                    displayName = CSTRING(ArsenalDiscard);
                    condition = QUOTE(call FUNC(canDiscard));
                    statement = QUOTE(call FUNC(arsenalDiscard));
                    icon = QPATHTOEF(assets,ui\loadout-discard.paa);\
                };
            };
        };
    };
};
