#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onEventSupportSpecialistMissionNotStarted

Description:
    This function is called when the Support Specialist mission could not be started.

Parameters:
    0: _supportType - Support type <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onEventSupportSpecialistMissionNotStarted),_this);

params[
    ["_supportType",nil,[""]]
];

if !assert(!isNil "_supportType") exitWith {};

ERROR_1("Support specialist mission could not be started for %1",_supportType);

[QGVAR(eventSupportSpecialistMissionSuccess), [_supportType, true]] call CBA_fnc_serverEvent;

nil;
