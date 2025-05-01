#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_ejectCrew

Description:
    Eject crew from vehicle

Parameters:
    0: _vehicle - Target vehicle <TYPE>
    1: _player - Caller <TYPE>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(ejectCrew),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};

crew _vehicle apply {
    private _unit = _x;

    // AI can't dismount; just delete them
    if (["I_UAV_AI","B_UAV_AI","O_UAV_AI","C_UAV_AI"] findIf { _unit isKindOf _x } >= 0) then {
        deleteVehicle _unit;
    } else {
        moveOut _unit;
    };
};

nil;
