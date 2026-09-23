#define COMPONENT util

#define DEBUG_MODE_NORMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_UTIL
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

// Don't attach objects, but delete them and load their class names into cargo
//#define ACE_CARGO_CONVERT_TO_CLASS
// Look for items to load this many meters around target vehicle
#define ACE_CARGO_LOAD_RADIUS 8
// ACE3 internal QVAR name for loaded items
#define ACE_CARGO_VARIABLE QUOTE(ace_cargo_loaded)
// QOL macro
#define ACE_VEHICLE_CARGO(vehicle) ((vehicle) getVariable [ACE_CARGO_VARIABLE, []])
