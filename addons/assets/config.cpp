#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        ammo[] = {
            QGVAR(Ammo40mm_EMP)
        };
        magazines[] = {
            QGVAR(40mm_EMP),
            QGVAR(Grenade_EMP)
        };
        units[] = {
            QGVAR(DespawnSuppressionBeacon),
            QGVAR(RemoteTraderPhoneBooth),
            QGVAR(RemoteTraderTerminal),
            QGVAR(SignHelperArsenal),
            QGVAR(SignHelperGarage),
            QGVAR(SupplyBoxLarge),
            QGVAR(SupplyBoxMedium),
            QGVAR(SupplyBoxSmall)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main"};
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "CfgAmmo.hpp"
#include "CfgCloudlets.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgSounds.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "Display3DEN.hpp"
