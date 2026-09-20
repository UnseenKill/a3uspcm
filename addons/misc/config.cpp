#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"a3uspcm_main","a3uspcm_util"};
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

#include "ACE_Medical_Injuries.hpp"
#include "CfgAddon.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

class UserActionGroups {
    class Common {
        group[] += {QGVAR(UAVTerminalOpen)};
    };
};

class CfgUserActions {
    class GVAR(UAVTerminalOpen) {
        displayName = "$STR_useract_uav_openuavterminal";
        tooltip = "";
        onActivate = QUOTE(player action[ARR_2(QQUOTE(UAVTerminalOpen),player)]);
    };
};
