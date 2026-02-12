#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsOnContactUpdate

Description:
    CBA_EVENT_AAFC_CONTACT_UPDATE event handler

Parameters:
    0: _unit - Reported contact unit to update <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsOnContactUpdate),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

private _contactKey = _unit getVariable QGVAR(contactKey);
if !assert(!isNil "_contactKey") exitWith {};
[_contactKey] spawn FUNC(tabletTargetsUpdateContact);

nil;
