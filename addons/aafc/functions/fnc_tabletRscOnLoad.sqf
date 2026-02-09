#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletRscOnOpen

Description:
    onLoad event handler coded into Rsc class.

Parameters:
    0: _display - Tablet display <DISPLAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletRscOnOpen),_this);

if !assert(params[
    ["_display", nil, [displayNull]]
]) exitWith {};

uiNamespace setVariable[QGVAR(display), _display];
[CBA_EVENT_AAFC_DIALOG_OPENED, [_display]] call CBA_fnc_localEvent;

nil;
