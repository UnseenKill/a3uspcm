#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onEventSupportSpecialistKilled

Description:
    Event handler

Parameters:
    0: _unit - Support specialist killed <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onEventSupportSpecialistKilled),_this);

params[
    ["_unit",objNull,[objNull]]
];

if !assert(!isNull _unit) exitWith {};

private _tent = _unit getVariable QGVAR(tent);
private _supportType = _tent getVariable QGVAR(supportType);

GVAR(supportSpecialists) set[_supportType, false];

// Somehow, when units get killed _inside_ the tent is killed, too.
// If this issue fixed at some point, take this into account but still check
// after a while if the tent is really dead.
[
    {
        params["_tent"];

        if (alive _tent) then {
            if !GVAR(requireSpecialists) then {
                [_tent] call FUNC(handlerSupportTentKilled);
            } else {
                private _supportType = _tent getVariable QGVAR(supportType);
                private _specialistClass = _tent getVariable QGVAR(specialistClass);

                [QGVAR(eventSupportStartSpecialistMission), [_supportType, _specialistClass]] call CBA_fnc_serverEvent;
            };
        };
    },
    [_tent],
    2.5
] call CBA_fnc_waitAndExecute;

nil;
