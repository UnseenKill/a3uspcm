#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_aafcOpenTablet

Description:
    Open Anti-Air Fire Control tablet

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(aafcOpenTablet),_this);

createDialog QEGVAR(aafc,ConfigTablet);

nil;
