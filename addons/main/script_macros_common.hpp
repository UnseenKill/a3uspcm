#define MAINPREFIX z

#define VERSION_CONFIG version = VERSION; \
    versionStr = QUOTE(VERSION_STR); \
    versionAr[] = {VERSION_AR}; \
    A3A_compatibility[] = {A3A_COMPAT_MAJOR, A3A_COMPAT_MINOR}

#include "\x\cba\addons\main\script_macros_common.hpp"

#ifndef SUBCOMPONENT
    #define COMPONENT_PATH_FRAGMENT COMPONENT
    #define COMPONENT_PATH_FRAGMENT_F COMPONENT_F
#else // SUBCOMPONENT
    #ifndef SUBCOMPONENT_PATH_BASE
        #define COMPONENT_PATH_FRAGMENT COMPONENT\SUBCOMPONENT
        #define COMPONENT_PATH_FRAGMENT_F COMPONENT_F\SUBCOMPONENT
    #else
        #define COMPONENT_PATH_FRAGMENT COMPONENT\SUBCOMPONENT_PATH_BASE\SUBCOMPONENT
        #define COMPONENT_PATH_FRAGMENT_F COMPONENT_F\SUBCOMPONENT_PATH_BASE\SUBCOMPONENT
    #endif // SUBCOMPONENT_PATH_BASE

    #undef COMPILE_FILE
    #define COMPILE_FILE(var1) COMPILE_FILE_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,var1)

    #undef COMPILE_FILE_CFG
    #define COMPILE_FILE_CFG(var1) COMPILE_FILE_CFG_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,var1)

    #undef COMPILE_SCRIPT
    #define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,var1)']

    #undef FUNC
    #define FUNC(var1) TRIPLES(SUBADDON,fnc,var1)

    #undef GVAR
    #define GVAR(var1) DOUBLES(SUBADDON,var1)

    #undef LOG_SYS_FORMAT
    #define LOG_SYS_FORMAT(LEVEL,MESSAGE) format ['[%1] (%2) %3: %4', toUpper 'PREFIX', 'SUBADDON', LEVEL, MESSAGE]

    #undef PATHTOF
    #define PATHTOF(var1) PATHTOF_SYS(PREFIX,COMPONENT_PATH_FRAGMENT,var1)

    // Localization strings macros
    #undef CSTRING
    #define CSTRING(var1) QUOTE(TRIPLES($STR,SUBADDON,var1))
    #undef LSTRING
    #define LSTRING(var1) QUOTE(TRIPLES(STR,SUBADDON,var1))
    #undef LLSTRING
    #define LLSTRING(var1) (localize LSTRING(var1))
#endif // SUBCOMPONENT

#undef PREP
#undef PREPMAIN
#ifdef DISABLE_COMPILE_CACHE
    #define LINKFUNC(var1) { call FUNC(var1) }
    #define LINKFUNCMAIN(var1) { call FUNCMAIN(var1) }
    #define PREP(var1) FUNC(var1) = compile preprocessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,functions\DOUBLES(fnc,var1))'
    #define PREPMAIN(var1) FUNCMAIN(var1) = compile preprocessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,functions\DOUBLES(fnc,var1))'
#else
    #define LINKFUNC(var1) FUNC(var1)
    #define LINKFUNCMAIN(var1) FUNCMAIN(var1)
    #define PREP(var1) ['PATHTO_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,functions\DOUBLES(fnc,var1))', 'FUNC(var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPMAIN(var1) ['PATHTO_SYS(PREFIX,COMPONENT_PATH_FRAGMENT_F,functions\DOUBLES(fnc,var1))', 'FUNCMAIN(var1)'] call SLX_XEH_COMPILE_NEW
#endif

#undef PATHTO_FNC
#define PATHTO_FNC(func) class func {\
    file = QPATHTOF(functions\DOUBLES(fnc,func).sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}

#ifndef LQLSTRING
    #define LQLSTRING(var1) localize QQUOTE(TRIPLES(STR,ADDON,var1))
#endif

#ifndef QADDON
    #define QADDON QUOTE(ADDON)
#endif
#ifndef QPREFIX
    #define QPREFIX QUOTE(PREFIX)
#endif
#ifndef QQPREFIX
    #define QQPREFIX QUOTE(QUOTE(PREFIX))
#endif
#ifndef QQUOTE
    #define QQUOTE(x) QUOTE(QUOTE(x))
#endif
