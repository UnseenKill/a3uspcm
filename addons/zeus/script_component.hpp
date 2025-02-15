#define COMPONENT zeus
#include "\z\a3uspcm\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_ZEUS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ZEUS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ZEUS
#endif

#ifndef DEBUG_MODE_FULL
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_macros.hpp"
#define CREW_STATIC_RADIUS 100
