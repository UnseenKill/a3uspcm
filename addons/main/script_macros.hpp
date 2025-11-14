#include "script_macros_common.hpp"

#define DISPLAY_NAME_UNIT(unit) (if isText(configOf unit >> "displayNameShort") then [{getText(configOf unit >> "displayNameShort")}, {getText(configOf unit >> "displayName")}])
#define DISPLAY_NAME_CLASS(config,class) (if isText(configFile >> QUOTE(config) >> class >> "displayNameShort") then [{getText(configFile >> QUOTE(config) >> class >> "displayNameShort")}, {getText(configFile >> QUOTE(config) >> class >> "displayName")}])

// Use this "NOP" macro to trick the type checker of HEMTT
#define ASSUME_VAR_TYPE(NAME,VALUE) (if false then { NAME = VALUE })
#define INIT_SAVE_GVAR(NAME) if true then {\
    GVAR(NAME) = false;\
    if false then { GVAR(NAME) = createHashMap };\
}
