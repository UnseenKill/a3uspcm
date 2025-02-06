#define COMPONENT Menu
#include "\z\a3uspcm\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_MENU
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MENU
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MENU
#endif

#ifndef DEBUG_MODE_FULL
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_macros.hpp"
#define MENU_SUBJECT_ID QUOTE(DOUBLES(ADDON,DiarySubject))
