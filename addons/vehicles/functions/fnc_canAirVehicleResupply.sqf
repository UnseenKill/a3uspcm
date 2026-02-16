#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_canAirVehicleResupply

Description:
    ACE3 interaction callback condition for air vehicle resupply.

Parameters:
    0: _target - Target vehicle <OBJECT>
    1: _player - Player interacting with the vehicle <OBJECT>

Optional:

Returns:
    <BOOL> True if the action should be shown, false if not.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
//TRACE_1(QFUNC(canAirVehicleResupply),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};
if !assert(!isNull _player) exitWith {};

if true exitWith { true };

alive _target && {
    !(_target getVariable[QGVAR(willResupply), false])
};
