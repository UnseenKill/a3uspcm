#define COMPONENT misc

#define DEBUG_MODE_NORMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MISC
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

#define CBA_EVENT_A3U_FLAGACTION QUOTE(TRIPLES(ADDON,event,A3U_flagAction))
