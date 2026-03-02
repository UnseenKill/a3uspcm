#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        magazines[] = {};
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main","ace_irlight","ace_medical_statemachine"};
        skipWhenMissingDependencies = 1;
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "AceMedicalStatemachine.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgHalsStore.hpp"
#include "CfgWeapons.hpp"
