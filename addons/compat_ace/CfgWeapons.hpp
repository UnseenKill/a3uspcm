class SlotInfo;
class PointerSlot: SlotInfo {
    compatibleItems[] += {
        QGVAR(ACE_DBAL_A3_Green_FL),
        QGVAR(ACE_DBAL_A3_Red_FL)
    };
};

class PointerSlot_Rail: PointerSlot {
    class compatibleItems {
        GVAR(ACE_DBAL_A3_Green_FL) = 1;
        GVAR(ACE_DBAL_A3_Red_FL) = 1;
    };
};

class asdg_SlotInfo;
class asdg_FrontSideRail: asdg_SlotInfo {
    class compatibleItems {
        GVAR(ACE_DBAL_A3_Green_FL) = 1;
        GVAR(ACE_DBAL_A3_Red_FL) = 1;
    };
};

class CfgWeapons {
    class acc_pointer_IR;
    class InventoryFlashLightItem_Base_F;

    class ACE_DBAL_A3_Green: acc_pointer_IR {
        MRT_SwitchItemPrevClass = QGVAR(ACE_DBAL_A3_Green_FL);
    };

    class ACE_DBAL_A3_Green_VP: ACE_DBAL_A3_Green {
        MRT_SwitchItemNextClass = QGVAR(ACE_DBAL_A3_Green_FL);
    };

    class GVAR(ACE_DBAL_A3_Green_FL): ACE_DBAL_A3_Green {
        scope = 1;
        MRT_SwitchItemNextClass = "ACE_DBAL_A3_Green";
        MRT_SwitchItemPrevClass = "ACE_DBAL_A3_Green_VP";
        MRT_SwitchItemHintText = CSTRING(Mode_Flashlight);

        class ItemInfo: InventoryFlashLightItem_Base_F {
            class Flashlight {
                ambient[] = {3,6,10};
                color[] = {300,600,1000};
                coneFadeCoef = 5;
                daylight = 0;
                direction = "laser dir";
                flareMaxDistance = 80;
                flaresize = 1;
                innerangle = 15;
                intensity = 32;
                outerangle = 85;
                position = "laser pos";
                scale[] = {1,1,1};
                size = 1;
                useflare = 1;
                volumeShape = "a3\data_f\VolumeLightFlashlight.p3d";

                class Attenuation {
                    constant = 0.3;
                    hardLimitEnd = 75;
                    hardLimitStart = 60;
                    linear = 0.1;
                    quadratic = 0.8;
                    start = 0;
                };
            };
        };
    };

    class ACE_DBAL_A3_Red: acc_pointer_IR {
        MRT_SwitchItemPrevClass = QGVAR(ACE_DBAL_A3_Red_FL);
    };

    class ACE_DBAL_A3_Red_VP: ACE_DBAL_A3_Red {
        MRT_SwitchItemNextClass = QGVAR(ACE_DBAL_A3_Red_FL);
    };

    class GVAR(ACE_DBAL_A3_Red_FL): ACE_DBAL_A3_Red {
        scope = 1;
        MRT_SwitchItemNextClass = "ACE_DBAL_A3_Red";
        MRT_SwitchItemPrevClass = "ACE_DBAL_A3_Red_VP";
        MRT_SwitchItemHintText = CSTRING(Mode_Flashlight);

        class ItemInfo: InventoryFlashLightItem_Base_F {
            class Flashlight {
                ambient[] = {3,6,10};
                color[] = {300,600,1000};
                coneFadeCoef = 5;
                daylight = 0;
                direction = "laser dir";
                flareMaxDistance = 80;
                flaresize = 1;
                innerangle = 15;
                intensity = 32;
                outerangle = 85;
                position = "laser pos";
                scale[] = {1,1,1};
                size = 1;
                useflare = 1;
                volumeShape = "a3\data_f\VolumeLightFlashlight.p3d";

                class Attenuation {
                    constant = 0.3;
                    hardLimitEnd = 75;
                    hardLimitStart = 60;
                    linear = 0.1;
                    quadratic = 0.8;
                    start = 0;
                };
            };
        };
    };
};
