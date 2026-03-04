class CfgVehicles {
    class Helicopter_Base_H;
    class rhsusf_CH53E_USMC: Helicopter_Base_H {
        slingLoadMaxCargoMass = 20000;
    };

    class rhsusf_stryker_base;
    class rhsusf_stryker_m1126_base: rhsusf_stryker_base {
        slingLoadCargoMemoryPoints[] = {"dispenser_marker19","dispenser_marker56","l_mirror_rot_axis","r_mirror_rot_axis"};
    };
};
