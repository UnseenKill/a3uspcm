#define COMPONENT loadout
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

// Allow to overwrite current vehicle's inventory with loadout within this many seconds
#define FORCE_LOADOUT_TIMEOUT 15
// Store this many loadouts (FILO)
#define MAX_LOADOUTS 6
