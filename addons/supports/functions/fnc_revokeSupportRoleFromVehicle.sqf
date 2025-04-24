#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_revokeSupportRoleFromVehicle

Description:
    Callback function to revoke a support role from a vehicle.

Parameters:
    0: _vehicle - Target <OBJECT>
    1: _player - Caller <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(revokeSupportRoleFromVehicle),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if (crew _vehicle isNotEqualTo []) then {
    group(crew _vehicle select 0) setVariable[QGVAR(supportType), nil, true];
    crew _vehicle apply {
        moveOut _x;
    };
};

private _supportType = _vehicle getVariable[QGVAR(supportType), false];
_vehicle setVariable[QGVAR(supportType), nil, true];

private _module = [_supportType] call FUNC(getSupportModule);
_module synchronizeObjectsRemove[_vehicle];

nil;
