#define COMPONENT loadout
#include "\z\a3uspcm\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_LOADOUT
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_LOADOUT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOADOUT
#endif

#ifndef DEBUG_MODE_FULL
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_macros.hpp"
#define MAX_LOADOUTS 6
