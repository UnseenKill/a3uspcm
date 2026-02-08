#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_securityCycleReference

Description:
    Cycle the reference point security commands refer to.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(securityCycleReference),_this);

if (GVAR(securityReferenceSetting) isEqualTo player) then {
    GVAR(securityReferenceSetting) = RETDEF(GVAR(securityReference),player);
} else {
    GVAR(securityReferenceSetting) = player;
};

TRACE_1(QFUNC(securityCycleReference),GVAR(securityReferenceSetting));

nil;
