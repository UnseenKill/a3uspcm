#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "A3A_core",
            "A3A_ultimate",
            "cba_common"
        };
        author = "$STR_A3USPCM_Author";
        authors[] = {};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgSettings.hpp"
