#define COMPONENT garrison_rework

// #define DEBUG_MODE_NORMAL
#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_GARRISON_REWORK
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\util\plugins\ui_builder\script_macros.hpp"

#define FILTER_BASES 0
#define FILTER_OUTPOSTS 1
#define FILTER_RESOURCES 2
#define FILTER_TOWNS 3
#define FILTER_POSTS 4
#define FILTER_AT_CAPACITY 5

#define CBA_EVENT_DIALOG_BUILT QUOTE(TRIPLES(ADDON,Event,DialogBuilt))
#define CBA_EVENT_DIALOG_LOADED QUOTE(TRIPLES(ADDON,Event,DialogLoaded))
#define CBA_EVENT_DIALOG_UNLOADED QUOTE(TRIPLES(ADDON,Event,DialogUnloaded))

#define CBA_EVENT_DIALOG_BTNCLOSE_CLICK QUOTE(TRIPLES(ADDON,Event,DialogBtnCloseClick))
#define CBA_EVENT_DIALOG_FILTER_CHANGED QUOTE(TRIPLES(ADDON,Event,DialogFilterChanged))
#define CBA_EVENT_DIALOG_LOCATION_DBLCLICK QUOTE(TRIPLES(ADDON,Event,DialogLocationDblClick))
#define CBA_EVENT_DIALOG_LOCATION_SELECTED QUOTE(TRIPLES(ADDON,Event,DialogLocationSelected))
#define CBA_EVENT_DIALOG_UNITTYPE_SLIDER_CHANGED QUOTE(TRIPLES(ADDON,Event,DialogUnitTypeSliderChanged))

#define CBA_EVENT_UPDATE_LOCATIONS QUOTE(TRIPLES(ADDON,Event,UpdateLocations))
