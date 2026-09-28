#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onBtnCloseClick

Description:
    CBA_EVENT_DIALOG_BTNCLOSE_CLICK event handler

Parameters:
    0: _control - control that triggered the close event <CONTROL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onBtnCloseClick),_this);

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

ctrlParent _control closeDisplay 0;

nil;
