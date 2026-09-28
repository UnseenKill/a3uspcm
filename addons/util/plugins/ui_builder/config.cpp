#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        addonRootClass = QUOTE(DOUBLES(PREFIX,garrison));
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {};
    };
};

#include "CfgEventHandlers.hpp"
