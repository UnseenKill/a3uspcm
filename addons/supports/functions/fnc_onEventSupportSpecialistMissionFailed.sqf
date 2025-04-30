#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onEventSupportSpecialistMissionFailed

Description:
    This function is called when the Support Specialist mission fails.

Parameters:
    0: _supportType - Support type <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onEventSupportSpecialistMissionFailed),_this);

params[
    ["_supportType",nil,[""]]
];

if !assert(!isNil "_supportType") exitWith {};
if !assert(_supportType in GVAR(supportBuildings)) exitWith {
    ERROR_1("Support specialist acquired, but no building for %1",_supportType);
};

private _config = configFile >> QGVAR(Config) >> "Missions" >> _supportType;

if !assert(!isClass _config) exitWith {};

[
    getText(_config >> "missionCaption"),
    getText(_config >> "missionFailed")
] remoteExec["A3A_fnc_customHint", owner theBoss];
["A3AP_UiFailure"] remoteExec["playSound", owner theBoss];

GVAR(supportSpecialistsMissions) deleteAt _supportType;
[QGVAR(eventSupportStartSpecialistMission), [_supportType, 600 + random 600]] call CBA_fnc_serverEvent;

nil;
