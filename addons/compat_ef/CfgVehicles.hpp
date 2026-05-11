class CfgVehicles {
    class UAV_03_base_F;

    class UAV_03_dynamicLoadout_base_F: UAV_03_base_F {
        class Components {
            class TransportPylonsComponent {
                class Pylons {
                    class Pylons1;
                    class Pylons2;
                    class Pylons3;
                    class Pylons4;
                };
            };
        };
    };

    class B_T_UAV_03_dynamicLoadout_F: UAV_03_dynamicLoadout_base_F {};

    class DOUBLES(PREFIX,I_T_UAV_03_dynamicLoadout_F): B_T_UAV_03_dynamicLoadout_F {
        crew = "I_UAV_AI";
        faction = "IND_F";
        side = 2;

        displayName = CSTRING(I_T_UAV_03_dynamicLoadout_F_Display);

        class Components: Components {
            class TransportPylonsComponent: TransportPylonsComponent {
                class Pylons: Pylons {
                    class Pylons1: Pylons1 {
                        hardpoints[] += {"TITAN_NLOS_1RND"};
                    };
                    class Pylons2: Pylons2 {
                        hardpoints[] += {"TITAN_NLOS_1RND", "TITAN_NLOS_2RND"};
                    };
                    class Pylons3: Pylons3 {
                        hardpoints[] += {"TITAN_NLOS_1RND", "TITAN_NLOS_2RND"};
                    };
                    class Pylons4: Pylons4 {
                        hardpoints[] += {"TITAN_NLOS_1RND"};
                    };
                };
            };
        };
    };
};
