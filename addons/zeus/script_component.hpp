#define COMPONENT zeus
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"
#define CREW_FIRE_REPORT_INTERVAL_MS 1250
#define CREW_STATIC_WAIT 5
#define FIND_STATIC_RADIUS 100
#define REORIENT_OBJECT_WAIT 5

#define DISPLAY_NAME_UNIT(unit) (if isText(configOf unit >> "displayNameShort") then [{getText(configOf unit >> "displayNameShort")}, {getText(configOf unit >> "displayName")}])
#define DISPLAY_NAME_CLASS(config,class) (if isText(configFile >> QUOTE(config) >> class >> "displayNameShort") then [{getText(configFile >> QUOTE(config) >> class >> "displayNameShort")}, {getText(configFile >> QUOTE(config) >> class >> "displayName")}])
