#define COMPONENT garrison_rework

// #define DEBUG_MODE_NORMAL
#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_GARRISON_REWORK
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

#define CBA_EVENT_DIALOG_BUILT QUOTE(TRIPLES(ADDON,Event,DialogBuilt))
#define CBA_EVENT_DIALOG_LOADED QUOTE(TRIPLES(ADDON,Event,DialogLoaded))
#define CBA_EVENT_DIALOG_UNLOADED QUOTE(TRIPLES(ADDON,Event,DialogUnloaded))
