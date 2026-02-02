#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_revealLocation

Description:
    Action callback for enemy flags to reveal their location on the map.

Parameters:
    0: _object - Flag object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(revealLocation),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

private _marker = _object getVariable QGVAR(marker);
if !assert(!isNil "_marker") exitWith {};

[_marker] call A3U_fnc_revealZone;
_object setVariable[QGVAR(marker), nil];

nil;
