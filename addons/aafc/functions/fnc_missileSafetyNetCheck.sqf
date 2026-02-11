#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_missileSafetyNetCheck

Description:
    Check if missile fired by an objects is from an A/A group and if so, check
    if it's allowed to fire.

Parameters:
    0: _unit - Unit firing the missile <OBJECT>
    1: _projectile - Missile projectile <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(missileSafetyNetCheck),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_projectile", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _projectile) exitWith {};

if !GVAR(missileSafetyNet) exitWith {};

// Shortcut: playable units are allowed to fire
if (_vehicle in playableUnits) exitWith {};
// Shortcut: if variable is found, allow the projectile
if ([_vehicle] call FUNC(canUnitFire)) exitWith {};

private _index = GVAR(groups) findIf {
    _x getVariable QGVAR(vehicles) findIf {
        [_x] call FUNC(canUnitFire);
    } != -1;
};

if (_index isEqualTo -1) then {
    INFO_2("Deleting unauthorized missile '%1' from '%2'",_projectile,_vehicle);
    deleteVehicle _projectile;
};

nil;
