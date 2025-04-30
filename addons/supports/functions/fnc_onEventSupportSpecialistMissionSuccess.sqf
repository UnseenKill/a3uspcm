#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onEventSupportSpecialistMissionSuccess

Description:
    This function is called when the Support Specialist mission is successful.

Parameters:
    0: _supportType - Support type <STRING>

Optional:
    1: _forced - Forced <BOOL> (default: false)

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onEventSupportSpecialistMissionSuccess),_this);

params[
    ["_supportType",nil,[""]],
    ["_forced",false,[true]]
];

if !assert(!isNil "_supportType") exitWith {};
if !assert(_supportType in GVAR(supportBuildings)) exitWith {
    ERROR_1("Support specialist acquired, but no building for %1",_supportType);
};

private _config = configFile >> QGVAR(Config) >> "Missions" >> _supportType;

if !assert(isClass _config) exitWith {};

GVAR(supportSpecialists) set[_supportType, true];
[QGVAR(supportSpecialists), GVAR(supportSpecialists)] call A3A_fnc_setStatVariable;
GVAR(supportSpecialistsMissions) deleteAt _supportType;

[GVAR(supportBuildings) get _supportType] call FUNC(setupSupportTent);

if !_forced then {
    [
        getText(_config >> "missionCaption"),
        getText(_config >> "missionSuccess")
    ] remoteExec["A3A_fnc_customHint", owner theBoss];
    ["A3AP_UiSuccess"] remoteExec["playSound", owner theBoss];
};

nil;
