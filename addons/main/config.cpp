#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "A3A_Core",
            "cba_common"
        };
        author = "$STR_A3USPCM_Author";
        authors[] = {};
        url = "$STR_A3USPCM_URL";
        VERSION_CONFIG;
    };
};

class CfgSettings {
    class CBA {
        class Caching {
            functions = 1;
        };
        class Versioning {
            class PREFIX {
                class dependencies {
                    /*
                        // CBA requiring CBA_A2, if A2 is found
                        CBA_A2[] = {"cba_a2_main", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'Chernarus')"};
                        // CBA requiring CBA_OA, if OA is found
                        CBA_OA[] = {"cba_oa_main", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'Takistan')"};
                        // CBA requiring CBA_TOH, if TOH is found
                        CBA_TOH[] = {"cba_toh_main", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'United_States_H')"};
                    */
                    // CBA requiring CBA_A3, if A3 is found
                    CBA_A3[] = {"cba_main_a3", {1, 0, 0}, "isClass(configFile >> 'CfgPatches' >> 'A3_Map_Stratis')"};

                    XEH[] = {"cba_xeh", {1, 0, 0}, "(true)"};
                };
            };
        };
        class Registry {
            class PREFIX {
                removed[] = {"cba_linux", "cba_static_settings_addon", "cba_auto_load_settings_file"};
            };
        };
    };
};

#include "CfgVehicles.hpp"
