#define COMPONENT garrison

#define DEBUG_MODE_NORMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_GARRISON
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

#define CBA_EVENT_LOCATION_SELECTED QUOTE(TRIPLES(ADDON,event,locationSelected))
#define CBA_EVENT_PRESELECT_LOCATION QUOTE(TRIPLES(ADDON,event,preselectLocation))
