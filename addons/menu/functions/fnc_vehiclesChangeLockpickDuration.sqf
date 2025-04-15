#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_vehiclesChangeLockpickDuration

Description:
    Change the lockpick duration for vehicles

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(vehiclesChangeLockpickDuration),_this);

[(localize LSTRING(Vehicles_ChangeLockpickDurationPrompt)) + ":", str vehicleLockpickTime, {
    params["_amount"];

    _amount = parseNumber _amount;
    if (_amount isEqualType false || 0 == _amount) exitWith {};

    INFO_2("%1 changed lockpick duration to %2",name player,_amount);
    vehicleLockpickTime = _amount;

    [
        localize LSTRING(Vehicles_ChangeLockpickDurationCaption),
        format[localize LSTRING(Vehicles_ChangeLockpickDurationSuccess), _amount]
    ] call A3A_fnc_customHint;
}] call FUNCMAIN(utilPromptText);

nil;
