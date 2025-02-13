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

// Need to be this many meters around a FIA flag to apply loadouts
#define FIA_FLAG_LOADOUT_RADIUS 25
// Allow to overwrite current vehicle's inventory with loadout within this many seconds
#define FORCE_LOADOUT_TIMEOUT 15
// Allow loadout manipulation when in proximity of HQ/factory/outpost
#define LOADOUT_REQUIRE_FLAG_PROXIMITY
// Store this many loadouts (FILO)
#define MAX_LOADOUTS 6
