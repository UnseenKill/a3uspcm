#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_updateDelta

Description:
    CBA_EVENT_DIALOG_UPDATE_DELTA event handler

Parameters:
    0: _group - Recruitment control group <CONTROL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["_y"]
TRACE_1(QFUNC(updateDelta),_this);

if !assert(params[
    ["_group", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _group) exitWith {};

private _control = _group getVariable QUIBVAR(controls) get "DeltaInfo";

if (isNil { _group getVariable QGVAR(garrisonInfo) }) exitWith {
    _control ctrlSetText "";
};

private _garrisonInfo = _group getVariable QGVAR(garrisonInfo);
private _garrisonCount = [_garrisonInfo, [0, 0], {
    _accumulator set[0, (_accumulator select 0) + (_y get "unitCount")];
    _accumulator set[1, (_accumulator select 1) + (_y get "unitCountOriginal")];
    _accumulator;
}] call CBA_fnc_inject;

private _delta = (_garrisonCount select 0) - (_garrisonCount select 1);

_control ctrlSetText format["%1%2", [["±", "+"] select(_delta > 0), "-"] select(_delta < 0), abs _delta];
_control ctrlSetTooltip format["%1 / %2", _garrisonCount select 0, _garrisonCount select 1];
_control setVariable[QGVAR(delta), _delta];

switch true do {
    case (_delta > 0): { _control ctrlSetTextColor[0, 0.6, 0, 1] };
    case (_delta < 0): { _control ctrlSetTextColor[0.6, 0, 0, 1] };
    default { _control ctrlSetTextColor[0.75, 0.75, 0.75, 1] };
};

nil;
