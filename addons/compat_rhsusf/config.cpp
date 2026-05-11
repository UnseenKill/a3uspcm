#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        magazines[] = {};
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main","a3uspcm_store","rhsusf_main","rhsusf_ch53","rhsusf_stryker"};
        skipWhenMissingDependencies = 1;
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "CfgHalsStore.hpp"
#include "CfgVehicles.hpp"
