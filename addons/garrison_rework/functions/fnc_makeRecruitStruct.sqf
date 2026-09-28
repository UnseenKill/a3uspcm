#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_makeRecruitStruct

Description:
    Build structure for FUNC(recruitUnits) to work with

Parameters:
    0: _control - recruiting control group <CONTROL>

Optional:

Example:

Returns:
    <HASHMAP> structure with unit-type keys and recruitment delta

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(makeRecruitStruct),_this);

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

createHashMapFromArray(_control getVariable QGVAR(garrisonInfo) apply {
    private _unitType = _x;
    private _info = _y;

    [_unitType, (_y get "unitCount") - (_y get "unitCountOriginal")];
});
