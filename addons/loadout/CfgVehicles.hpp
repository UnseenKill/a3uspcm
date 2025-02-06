class CfgVehicles {
    class LandVehicle;

    class Car: LandVehicle {
		class ACE_Actions {
            class ACE_MainActions {
                class GVAR(LoadoutMenu) {
                    displayName = "$STR_A3USPCM_Loadout_MenuLoadout";
                    condition = QUOTE(alive _target);
                    insertChildren = QUOTE(call FUNC(getLoadoutMenuChildren));
                };
            };
        };
    };
};
