#define COMPONENT util
#include "\z\a3uspcm\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_UTIL
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_UTIL
    #define DEBUG_SETTINGS DEBUG_SETTINGS_UTIL
#endif

#ifndef DEBUG_MODE_FULL
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_macros.hpp"
