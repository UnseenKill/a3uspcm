#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_setUnitCanFire

Description:
    Set whether or not a unit is allowed to open fire and update its AI accordingly.

Parameters:
    0: _unit - Unit to set fire permission for <OBJECT>
    1: _canFire - Whether the unit is allowed to fire <BOOL>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(setUnitCanFire),_this);

if !assert(isServer) exitWith {};
if !assert(params[
    ["_unit", nil, [objNull]],
    ["_canFire", nil, [true]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

private _units = if !(isNil { _unit getVariable QGVAR(canFire)}) then {
    [_unit]
} else {
    crew _unit; // assume vehicle
};

_units apply {
    _x setVariable[QGVAR(canFire), _canFire, true];

    if (_canFire) then {
        _x enableAI "FIREWEAPON";
    } else {
        _x disableAI "FIREWEAPON";
    };
};

nil;
