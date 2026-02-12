#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_canUnitFire

Description:
    Whether or not an individual unit is allowed to open fire.

Parameters:
    0: _unit - Unit to check <OBJECT>

Optional:

Returns:
    <BOOL> true if the unit is allowed to fire, false otherwise

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(canUnitFire),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith { false };
if !assert(!isNull _unit) exitWith { false };

// Might be the vehicle we're checking here...
if (isNil {_unit getVariable QGVAR(canFire)}) then {
    _unit = gunner _unit;
};

if !assert(!isNull _unit) exitWith { false };

_unit getVariable[QGVAR(canFire), false];
