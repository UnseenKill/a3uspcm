#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_autouncompromize_fnc_escapeZoneTriggerOn

Description:
    Triggered when player leaves the escape zone

Parameters:
    0: _trigger - Trigger object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(escapeZoneTriggerOn),_this);

params[
    ["_trigger", objNull, [objNull]]
];

if (isNull _trigger) exitWith {};

deleteVehicle _trigger;

nil;
