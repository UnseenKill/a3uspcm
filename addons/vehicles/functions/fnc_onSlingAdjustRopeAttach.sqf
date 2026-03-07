#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_onSlingAdjustRopeAttach

Description:
    "RopeAttach" event handler for slingload adjustment.
    
    Sets the mass of the attached object to maxSlingloadBefore minus an 
    arbitrary value.

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
TRACE_1(QFUNC(onSlingAdjustRopeAttach),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_rope", nil, [objNull]],
    ["_attachedObject", nil, [objNull]]
]) exitWith {};
if !assert(alive _vehicle) exitWith {};
if !assert(!isNull _rope) exitWith {};
if !assert(!isNull _attachedObject) exitWith {};

// EH triggers multiple times, so lock early.
if !(isNil { _attachedObject getVariable QGVAR(ropeAttached) }) exitWith {};
_attachedObject setVariable[QGVAR(ropeAttached), true];

// Make vehicle lighter
_attachedObject setVariable[QGVAR(mass), getMass _attachedObject];
private _mass = [configOf _attachedObject >> QGVAR(slingLoadAdjustMassTo), "NUMBER", 1500] call CBA_fnc_getConfigEntry;
_attachedObject setMass _mass;

TRACE_2(QFUNC(onSlingAdjustRopeAttach),_attachedObject,_mass);

// Reset rope attached flag
[{
    _this setVariable[QGVAR(ropeAttached), nil];
}, _attachedObject, 5] call CBA_fnc_waitAndExecute;

nil;
