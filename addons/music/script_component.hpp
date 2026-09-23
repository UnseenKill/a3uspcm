#define COMPONENT music

#define DEBUG_MODE_NORMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MUSIC
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

// Remember last X tracks so they don't get played again immediately
#define REMEMBER_TRACKS 2
