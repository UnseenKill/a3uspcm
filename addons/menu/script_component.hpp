#define COMPONENT menu
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

// Params: Object player, String gvarName, Any value
#define CBA_EVENT_MENU_SYNCGVAR QUOTE(TRIPLES(ADDON,events,syncGVAR))

#define INTEL_CLEANUP_INTERVAL 10
#define INTEL_MARKER_RADIUS 8
#define MAX_CM_SHORTCUTS 8
#define MENU_SUBJECT_ID QUOTE(DOUBLES(ADDON,DiarySubject))
#define STRAGGLERS_MIN_DISTANCE 100
#define TELEPORT_BACK_TIMEOUT 180
