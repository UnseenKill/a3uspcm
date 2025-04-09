#define LOADOUT_ACTION_FOR_CLASS(className,parentClass) \
    class className : parentClass {\
        class ACE_Actions {\
            class ACE_MainActions {\
                class GVAR(LoadoutMenu) {\
                    displayName = CSTRING(MenuLoadout);\
                    condition = QUOTE(call FUNC(canUseLoadoutMenu));\
                    insertChildren = QUOTE(call FUNC(getLoadoutMenuChildren));\
                };\
                class GVAR(LoadoutDump) {\
                    displayName = CSTRING(DumpContents);\
                    condition = QUOTE(GVAR(aceInteractShowVehicleDumpAction) && (locked _target isEqualTo 0) && call FUNCMAIN(utilVehicleHasCargo));\
                    statement = QUOTE(call FUNC(containerDumpContents));\
                    icon = QPATHTOEF(assets,ui\loadout-unload.paa);\
                };\
            };\
        };\
    }

class CfgVehicles {
    class Air;
    class LandVehicle;
    class Ship;
    class ThingX;

    LOADOUT_ACTION_FOR_CLASS(Car,LandVehicle);
    LOADOUT_ACTION_FOR_CLASS(Tank,LandVehicle);
    LOADOUT_ACTION_FOR_CLASS(Helicopter,Air);
    LOADOUT_ACTION_FOR_CLASS(Plane,Air);
    LOADOUT_ACTION_FOR_CLASS(Ship_F,Ship);

    class ReammoBox_F : ThingX {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(DumpContents) {
                    displayName = CSTRING(DumpContents);
                    condition = QUOTE(call FUNCMAIN(utilVehicleHasCargo));
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
