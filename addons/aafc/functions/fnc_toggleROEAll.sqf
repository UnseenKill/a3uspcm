#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_toggleROEAll

Description:
    Toggle ROE for all groups

Parameters:

Optional:

Example:

Returns:
    Nothing

Scope:
    Client, Unscheduled

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(toggleROEAll),_this);

private _newROE = [ROE_FIREATWILL, ROE_HOLDFIRE] select(GVAR(globalROE) isNotEqualTo ROE_HOLDFIRE);

TRACE_1(QFUNC(toggleROEAll),_newROE);
CBA_EVENT_SERVER(CBA_EVENT_AAFC_SET_ROE_GLOBAL,[_newROE]);

nil;
