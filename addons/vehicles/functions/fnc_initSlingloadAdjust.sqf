#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_initSlingloadAdjust

Description:
    Initializes the slingload adjustment for helicopters.

Parameters:
    0: _vehicle - Helicopter object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initSlingloadAdjust),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(alive _vehicle) exitWith {};

if (getNumber(configOf _vehicle >> QGVAR(slingLoadAdjust)) isEqualTo 0) exitWith {
    TRACE_1(QFUNC(initSlingloadAdjust),_vehicle);
};

_vehicle addEventHandler["RopeAttach", { call FUNC(onSlingAdjustRopeAttach) }];
_vehicle addEventHandler["RopeBreak", { call FUNC(onSlingAdjustRopeDetach) }];

nil;
