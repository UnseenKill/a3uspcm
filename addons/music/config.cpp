#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main","a3uspcm_util"};
        skipWhenAnyAddonPresent[] = {"A3A_ultimate_tracklist_editor"};
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "CfgAddon.hpp"
#include "CfgEventHandlers.hpp"
#include "dialog.hpp"
