#define COMPONENT supports
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

#define SUPPORT_TYPE_ARTILLERY_P artillery
#define SUPPORT_TYPE_CAS_HELICOPTER_P cas_helicopter
#define SUPPORT_TYPE_CAS_PLANE_P cas_plane
#define SUPPORT_TYPE_TRANSPORT_P transport

#define SUPPORT_TYPE_ARTILLERY QUOTE(SUPPORT_TYPE_ARTILLERY_P)
#define SUPPORT_TYPE_CAS_PLANE QUOTE(SUPPORT_TYPE_CAS_PLANE_P)
#define SUPPORT_TYPE_CAS_HELICOPTER QUOTE(SUPPORT_TYPE_CAS_HELICOPTER_P)
#define SUPPORT_TYPE_TRANSPORT QUOTE(SUPPORT_TYPE_TRANSPORT_P)

#define SUPPORT_TYPES_MAP [ \
    [SUPPORT_TYPE_ARTILLERY, "Artillery"], \
    [SUPPORT_TYPE_CAS_HELICOPTER, "CAS_Heli"], \
    [SUPPORT_TYPE_CAS_PLANE, "CAS_Bombing"], \
    [SUPPORT_TYPE_TRANSPORT, "Transport"] \
]

#define SUPPORT_MODULES_MAP [\
    [SUPPORT_TYPE_ARTILLERY, "SupportProvider_Artillery"], \
    [SUPPORT_TYPE_CAS_PLANE, "SupportProvider_CAS_Bombing"], \
    [SUPPORT_TYPE_CAS_HELICOPTER, "SupportProvider_CAS_Heli"], \
    [SUPPORT_TYPE_TRANSPORT, "SupportProvider_Transport"] \
]
