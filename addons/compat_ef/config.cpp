#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        magazines[] = {};
        units[] = {
            QUOTE(DOUBLES(PREFIX,I_T_UAV_03_dynamicLoadout_F))
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main","a3uspcm_store","EF_Weapons","A3A_hals"};
        skipWhenMissingDependencies = 1;
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "CfgHalsStore.hpp"
#include "CfgVehicles.hpp"
