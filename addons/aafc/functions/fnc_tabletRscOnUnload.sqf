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

CBA_TRIGGER(CBA_EVENT_AAFC_DIALOG_CLOSED,[uiNamespace getVariable QGVAR(display)]);

uiNamespace getVariable QGVAR(events) apply {
    _x call CBA_fnc_removeEventHandler;
};

uiNamespace setVariable[QGVAR(display), nil];
uiNamespace setVariable[QGVAR(events), nil];

nil;
