#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {
            QGVAR(DespawnSuppressionBeacon)
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

#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"
#include "CfgVehicles.hpp"
