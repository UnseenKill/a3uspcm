#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_acknowledgeROEChange

Description:
    Event handler for CBA_EVENT_AAFC_UNIT_ROE_CHANGED. Acknowledge ROE change
    via side chat.

Parameters:
    0: _vehicle - A/A vehicle <OBJECT>
    1: _roeLevel - New ROE level <NUMBER>
    2: _allowFire - Allow fire flag <BOOLEAN>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(acknowledgeROEChange),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_roeLevel", nil, [0]],
    ["_allowFire", nil, [true]]
]) exitWith {};

private _group = _vehicle getVariable QGVAR(group);
if !assert(!isNil "_group") exitWith {};
if !assert(!isNull _group) exitWith {};

private _message = [LSTRING(Message_ROE_AcceptHold), LSTRING(Message_ROE_AcceptFire)] select _allowFire;
[leader _group, localize _message] remoteExec["sideChat", -2];

nil;
