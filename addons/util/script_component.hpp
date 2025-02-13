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

// Don't attach objects, but delete them and load their class names into cargo
//#define ACE_CARGO_CONVERT_TO_CLASS
// Look for items to load this many meters around target vehicle
#define ACE_CARGO_LOAD_RADIUS 8
// ACE3 internal QVAR name for loaded items
#define ACE_CARGO_VARIABLE QUOTE(ace_cargo_loaded)
// QOL macro
#define ACE_VEHICLE_CARGO(vehicle) ((vehicle) getVariable [ACE_CARGO_VARIABLE, []])
