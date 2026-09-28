#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onTerminateUI

Description:
    CBA_EVENT_TERMINATE_UI event handler

Parameters:
    0: _remotePlayer - The player taking over AGM <STRING>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onTerminateUI),_this);

if !assert(params[
    ["_remotePlayer", nil, [""]]
]) exitWith {};

uiNamespace getVariable QGVAR(display) closeDisplay 2;
[LLSTRING(Dialog_MainTitle), format[LLSTRING(TerminateUI_Message), _remotePlayer]] call A3A_fnc_customHint;
    
nil;
