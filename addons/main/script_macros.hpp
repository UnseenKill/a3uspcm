#include "script_macros_common.hpp"
#include "cba_events.hpp"

#define DISPLAY_NAME_UNIT(unit) (if isText(configOf unit >> "displayNameShort") then [{getText(configOf unit >> "displayNameShort")}, {getText(configOf unit >> "displayName")}])
#define DISPLAY_NAME_CLASS(config,class) (if isText(configFile >> QUOTE(config) >> class >> "displayNameShort") then [{getText(configFile >> QUOTE(config) >> class >> "displayNameShort")}, {getText(configFile >> QUOTE(config) >> class >> "displayName")}])

// To fool HEMTT's type guessing
#define ASSUME_VARIABLE_TYPE(var, type) (if false then { var = type })
