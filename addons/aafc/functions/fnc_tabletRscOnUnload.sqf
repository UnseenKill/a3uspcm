#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletRscOnUnload

Description:
    onUnload event handler coded into Rsc class.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletRscOnUnload),_this);

[CBA_EVENT_AAFC_DIALOG_CLOSED, [uiNamespace getVariable QGVAR(display)]] call CBA_fnc_localEvent;
uiNamespace setVariable[QGVAR(display), nil];

nil;
