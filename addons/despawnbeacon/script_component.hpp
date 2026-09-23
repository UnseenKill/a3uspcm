#define COMPONENT despawnbeacon

#define DEBUG_MODE_NORMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_DESPAWNBEACON
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

#define CBA_EVENT_DSB_POSTINIT QUOTE(TRIPLES(ADDON,beacon,postInit))
