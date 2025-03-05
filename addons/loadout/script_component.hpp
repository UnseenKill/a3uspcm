#define COMPONENT loadout
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

// Container must be closer than this many meters to arsenal box to unlock arsenal interactions
#define ARSENAL_INTERACTION_RADIUS 20
// Allow to overwrite current vehicle's inventory with loadout within this many seconds
#define FORCE_LOADOUT_TIMEOUT 15
// Store this many loadouts (FILO)
#define MAX_LOADOUTS 6
