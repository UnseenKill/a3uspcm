#define PREFIX A3USPCM

#include "script_production.hpp"
#include "script_version.hpp"

#define VERSION     MAJOR.MINOR
#define VERSION_STR MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR  MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 2.20

// Antistasi Ultimate compatibility
#define A3A_COMPAT_MAJOR 12
#define A3A_COMPAT_MINOR 0

// Define DEBUG_MODE_FULL for full debug mode when not in production and not
// otherwise already specified
#ifndef __A3USPCM_PRODUCTION__
    #ifndef DEBUG_MODE_NORMAL
        #ifndef DEBUG_MODE_FULL
            #define DEBUG_MODE_FULL
        #endif
    #endif
#endif

#ifdef __A3USPCM_PRODUCTION__
    // Remove CfgFunction adding headers and disable SCRIPT macro
    #define SKIP_FUNCTION_HEADER // [Enable for release]
    #define SKIP_SCRIPT_NAME // [Enable for release]
#else
    #define RECOMPILE // [Disable for release]
    #define DISABLE_COMPILE_CACHE
#endif

#include "\z\a3uspcm\addons\main\script_macros.hpp"
