#define COMPONENT zeus
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"
#define CREW_STATIC_WAIT 5
#define FIND_STATIC_RADIUS 100
#define REORIENT_OBJECT_WAIT 5
#define TEST_CAN_GARAGE(VEHICLE) (\
    ((VEHICLE) isKindOf "LandVehicle") ||\
    { (VEHICLE) isKindOf "StaticWeapon" } ||\
    { (VEHICLE) isKindOf "Air" } ||\
    { (VEHICLE) isKindOf "Ship" } \
)

#define TEST_NOCIGS_IN_GWH(testPosition) \
    (nearestObjects[testPosition, ["GroundWeaponHolder","WeaponHolderSimulated"], 300, true] select { \
        !(_x isKindOf "cigs_base_cigpackItem") && { \
            (weaponCargo _x isNotEqualTo []) || \
            {backpackCargo _x isNotEqualTo []} || { \
                (itemCargo _x findIf { _x find "cigs_" isEqualTo 0 } isEqualTo -1) && \
                {magazineCargo _x findIf { _x find "cigs_" isEqualTo 0 } isEqualTo -1} \
            } \
        }; \
    })
