#define SELL_ACTION_FOR_CLASS(className,parentClass) \
    class className : parentClass {\
        class ACE_Actions {\
            class ACE_MainActions {\
                class GVAR(AdvancedSelling) {\
                    displayName = CSTRING(AdvSell_InteractionSell_DisplayName);\
                    condition = QUOTE(ADDON && { call FUNC(canStartAdvancedSelling) });\
                    statement = QUOTE(call FUNC(startAdvancedSelling));\
                };\
            };\
        };\
    }

class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Air;
    class LandVehicle;
    class Ship;
    class ThingX;
    class Weapon_Bag_Base;

    SELL_ACTION_FOR_CLASS(Car,LandVehicle);
    SELL_ACTION_FOR_CLASS(Helicopter,Air);
    SELL_ACTION_FOR_CLASS(Plane,Air);
    SELL_ACTION_FOR_CLASS(Ship_F,Ship);
    SELL_ACTION_FOR_CLASS(Tank,LandVehicle);

    class ReammoBox_F : ThingX {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(AdvancedSelling) {
                    displayName = CSTRING(AdvSell_InteractionSell_DisplayName);
                    condition = QUOTE(ADDON && { call FUNC(canStartAdvancedSelling) });
                    statement = QUOTE(call FUNC(startAdvancedSelling));
                };
            };
        };

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    class B_UAV_01_backpack_F: Weapon_Bag_Base {
        GVAR(fallbackSellPrice) = 3500;
    };

    class B_G_UAV_02_IED_backpack_lxWS: Weapon_Bag_Base {
        GVAR(fallbackSellPrice) = 3500;
    };

    class I_UAV_02_backpack_lxWS: Weapon_Bag_Base {
        GVAR(fallbackSellPrice) = 3500;
    };

    class UAV_06_backpack_base_F: Weapon_Bag_Base {
        GVAR(fallbackSellPrice) = 3500;
    };

    class UGV_02_backpack_base_F: Weapon_Bag_Base {
        GVAR(fallbackSellPrice) = 3500;
    };
};
