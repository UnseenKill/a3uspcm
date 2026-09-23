#define COMPONENT compat_ace

#define DEBUG_MODE_NORMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_COMPAT_ACE
    #define DEBUG_MODE_FULL
#endif

#include "\z\a3uspcm\addons\main\script_mod.hpp"

#define ACE_EGVAR(var1,var2) TRIPLES(ace,var1,var2)
#define ACE_QEGVAR(var1,var2) QUOTE(ACE_EGVAR(var1,var2))
