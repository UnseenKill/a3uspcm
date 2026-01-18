#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        magazines[] = {
            QGVAR(8Rnd_60mm_Mo_shells_RF),
            QGVAR(8Rnd_82mm_Mo_Flare_white),
            QGVAR(8Rnd_82mm_Mo_Flare_white_illumination),
            QGVAR(8Rnd_82mm_Mo_Smoke_white),
            QGVAR(8Rnd_82mm_Mo_guided),
            QGVAR(8Rnd_82mm_Mo_LG)
        };
        units[] = {};
        weapons[] = {
            QGVAR(mortar_60mm_RF_carry)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main","ace_csw","RF_Weapons"};
        skipWhenMissingDependencies = 1;
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "CfgAceCSW.hpp"
#include "CfgMagazines.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
