#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onEventSupportSpecialistMissionSuccess

Description:
    This function is called when the Support Specialist mission is successful.

Parameters:
    0: _supportType - Support type <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onEventSupportSpecialistMissionSuccess),_this);

params[
    ["_supportType",nil,[""]]
];

if !assert(!isNil "_supportType") exitWith {};



nil;
