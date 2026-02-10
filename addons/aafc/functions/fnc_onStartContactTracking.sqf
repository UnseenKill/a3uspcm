#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_onStartContactTracking

Description:
    Handler for CBA_EVENT_AAFC_START_CONTACT_TRACK event to initialize contact
    tracking.

Parameters:
    0: _unit - Unit to track <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onStartContactTracking),_this);

if !assert(params[
    ["_unit", objNull, [objNull]]
]) exitWith {};

if !assert(!isNull _unit) exitWith {};
if !GVAR(trackContacts) exitWith {};

private _key = hashValue _unit;

TRACE_1(QFUNC(onStartContactTracking),_key);

if (GVAR(contacts) getOrDefault[_key, false] isNotEqualTo false) exitWith {
    WARNING_2("Contact tracking already initialized for unit '%1' with key '%2'",_unit,_key);
};

[_unit, _key] call FUNC(trackContact);

nil;
