class CfgWeapons {
    class ItemCore;
    class Launcher;
    class Rifle;

    class HandGunBase: Rifle {
        GVAR(fallbackSellPrice) = 450;
    };

    class H_HelmetB: ItemCore {
        GVAR(fallbackSellPrice) = 300;
    };

    class HelmetBase: ItemCore {
        GVAR(fallbackSellPrice) = 300;
    };

    class Launcher_Base_F: Launcher {
        GVAR(fallbackSellPrice) = 1500;
    };

    class launch_Titan_base: Launcher_Base_F {
        GVAR(fallbackSellPrice) = 3500;
    };

    class Rifle_Base_F: Rifle {
        GVAR(fallbackSellPrice) = 800;
    };

    class Vest_Camo_Base: ItemCore {
        GVAR(fallbackSellPrice) = 500;
    };
};
