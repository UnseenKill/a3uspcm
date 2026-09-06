#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_addDroneActions

Description:
    Add additional ACE actions to drones

Parameters:
    0: _vehicle - the drone vehicle to which ACE actions will be added <OBJECT>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(addDroneActions),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};

if !(alive _vehicle) exitWith {};
if !(isNil { _vehicle getVariable QGVAR(addedDroneActions) }) exitWith {};

_vehicle setVariable[QGVAR(addedDroneActions), true];

if (_vehicle isKindOf "Air") then {
    private _action = [
        QGVAR(droneAlignBody), LLSTRING(Drone_AlignBodyText), "",
        { call FUNC(droneAlignBody) },
        { !(isTouchingGround(_this select 0)) && {(ACE_controlledUAV select 2) isEqualTo [0]} }
    ] call ace_interact_menu_fnc_createAction;

    [_vehicle, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

nil;
