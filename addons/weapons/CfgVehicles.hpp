class CfgVehicles {
    class LandVehicle;

    class Tank: LandVehicle {
        class ACE_SelfActions {
            class GVAR(VehicleWeapons) {
                displayName = CSTRING(VehicleWeaponsSelfActionsMenuText);
                icon = QUOTE(a3\ui_f\data\igui\cfg\actions\gear_ca.paa);
                condition = QUOTE(call FUNC(vehicleWeaponCanUseMenu));
                statement = "";

                class GVAR(AddWeapon) {
                    displayName = CSTRING(VehicleWeaponsSelfActionsAddWeaponText);
                    condition = QUOTE(true);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(vehicleWeaponGetAddWeaponChildren));
                };

                class GVAR(RemoveWeapon) {
                    displayName = CSTRING(VehicleWeaponsSelfActionsRemoveWeaponText);
                    condition = QUOTE(call FUNC(vehicleWeaponCanRemove));
                    statement = QUOTE(call FUNC(vehicleWeaponRemove));
                };
            };
        };
    };
};
