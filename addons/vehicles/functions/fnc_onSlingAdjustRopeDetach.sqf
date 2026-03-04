#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_onSlingAdjustRopeDetach

Description:
    "RopeBreak" event handler for slingload adjustment.
    
    Resets the mass of the attached object.

Parameters:
    0: _vehicle - Helicopter object <OBJECT>
    1: _rope - Rope object <OBJECT>
    2: _attachedObject - Attached object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onSlingAdjustRopeDetach),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_rope", nil, [objNull]],
    ["_attachedObject", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _rope) exitWith {};
if !assert(!isNull _attachedObject) exitWith {};

// EH triggers multiple times, so lock early.
if !(isNil { _attachedObject getVariable QGVAR(ropeDetached) }) exitWith {};
_attachedObject setVariable[QGVAR(ropeDetached), true];

// Restore vehicle mass
if assert(!isNil { _vehicle getVariable QGVAR(mass) }) then {
    private _mass = _vehicle getVariable QGVAR(mass);
    TRACE_2(QFUNC(onSlingAdjustRopeDetach),_attachedObject,_mass);
    _vehicle setMass _mass;
    _vehicle setVariable[QGVAR(mass), nil];
};

// Reset rope detached flag
[{
    _this setVariable[QGVAR(ropeDetached), nil];
}, _attachedObject, 5] call CBA_fnc_waitAndExecute;

nil;
