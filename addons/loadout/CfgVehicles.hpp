#define LOADOUT_ACTION_FOR_CLASS(className,parentClass) \
    class className : parentClass {\
        class ACE_Actions {\
            class ACE_MainActions {\
                class GVAR(LoadoutMenu) {\
                    displayName = "$STR_A3USPCM_Loadout_MenuLoadout";\
                    condition = QUOTE(call FUNC(canUseLoadoutMenu));\
                    insertChildren = QUOTE(call FUNC(getLoadoutMenuChildren));\
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
                    statement = QUOTE(call FUNC(containerDumpContents));
                };
            };
        };
    };
};
