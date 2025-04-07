#define WPNEDITOR_ACTION_FOR_CLASS(className,parentClass) \
    class className: parentClass { \
        class ACE_SelfActions { \
            class GVAR(VehicleHK) { \
                displayName = CSTRING(VehicleHunterKillerEnableText); \
                icon = QUOTE(a3\ui_f\data\igui\cfg\actions\getingunner_ca.paa); \
                condition = QUOTE(call FUNC(vehicleHunterKillerCanEnable)); \
                statement = QUOTE(call FUNC(vehicleHunterKillerEnable)); \
            }; \
            class GVAR(VehicleWeapons) { \
                displayName = CSTRING(VehicleWeaponsSelfActionsMenuText); \
                icon = QUOTE(a3\ui_f\data\igui\cfg\actions\gear_ca.paa); \
                condition = QUOTE(call FUNC(vehicleWeaponCanUseMenu)); \
                statement = ""; \
                class GVAR(AddWeapon) { \
                    displayName = CSTRING(VehicleWeaponsSelfActionsAddWeaponText); \
                    condition = QUOTE(true); \
                    statement = ""; \
                    insertChildren = QUOTE(call FUNC(vehicleWeaponGetAddWeaponChildren)); \
                }; \
                class GVAR(RemoveWeapon) { \
                    displayName = CSTRING(VehicleWeaponsSelfActionsRemoveWeaponText); \
                    condition = QUOTE(call FUNC(vehicleWeaponCanRemove)); \
                    statement = QUOTE(call FUNC(vehicleWeaponRemove)); \
                }; \
            }; \
        }; \
    }

class CfgVehicles {
    class Air;
    class LandVehicle;
    class Ship;

    WPNEDITOR_ACTION_FOR_CLASS(Car,LandVehicle);
    WPNEDITOR_ACTION_FOR_CLASS(Tank,LandVehicle);
    WPNEDITOR_ACTION_FOR_CLASS(Helicopter,Air);
    WPNEDITOR_ACTION_FOR_CLASS(Plane,Air);
    WPNEDITOR_ACTION_FOR_CLASS(Ship_F,Ship);
};
