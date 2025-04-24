#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_assignSupportRoleToVehicle

Description:
    Callback function to assign a support role to a vehicle.

Parameters:
    0: _vehicle - Target <OBJECT>
    1: _player - Caller <OBJECT>
    2: _supportType - Support type <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(assignSupportRoleToVehicle),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_supportType", "", [""]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if (crew _vehicle isEqualTo []) then {
    private _group = side _player createVehicleCrew _vehicle;
    _player hcSetGroup[_group];
};

private _module = [_supportType] call FUNC(getSupportModule);

_vehicle synchronizeObjectsAdd[_module];

nil;
