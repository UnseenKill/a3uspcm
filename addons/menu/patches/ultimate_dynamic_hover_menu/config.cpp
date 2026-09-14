#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        addonRootClass = QUOTE(DOUBLES(PREFIX,menu));
        requiredAddons[] = {"A3A_ultimate_dynamic_hover_menu"};
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
    };
};

class A3U {
    #include "CfgMapContextMenu.hpp"
};
