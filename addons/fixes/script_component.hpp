#define COMPONENT fixes
#include "\z\a3uspcm\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_FIXES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_FIXES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_FIXES
#endif

#ifndef DEBUG_MODE_FULL
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_macros.hpp"
