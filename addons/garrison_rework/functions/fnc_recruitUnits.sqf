#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_recruitUnits

Description:
    Recruit/dismiss units for given location

Parameters:
    0: _location - marker name of location <STRING>
    1: _struct - structure with unit-type keys and recruitment delta <HASHMAP>

Optional:
    2: _completionKey - key to write to caller's mission namespace upon completion <STRING>

Example:

Returns:
    Nothing

Environment:
    Server, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(recruitUnits),_this);

if !assert(isServer) exitWith { ERROR_1("function ""%1"" not called on server",QFUNC(recruitUnits)) };
if !assert(canSuspend) exitWith { ERROR_1("function ""%1"" was `remoteExecCall`'ed",QFUNC(recruitUnits)) };

if !assert(params[
    ["_location", nil, [""]],
    ["_struct", nil, [createHashMap]]
]) exitWith {};

private _completionKey = param[2, nil, [""]];

uiSleep 2;

if !(isNil "_completionKey") then {
    missionNamespace setVariable[_completionKey, true, remoteExecutedOwner];
};

nil;
