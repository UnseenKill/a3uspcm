#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onUnitTypeSliderChanged

Description:
    CBA_EVENT_DIALOG_UNITTYPE_SLIDER_CHANGED event handler

Parameters:
    0: _control - slider that changed <CONTROL>
    1: _value - new value of the slider <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onUnitTypeSliderChanged),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_value", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _group = ctrlParentControlsGroup _control;
private _garrisonInfo = _group getVariable QGVAR(garrisonInfo);
private _thisInfo = _garrisonInfo get(_control getVariable QGVAR(unitType));

if !(GVAR(allowUnitDismissal)) then {
    if (_value < _thisInfo get "unitCountOriginal") then {
        _value = _thisInfo get "unitCountOriginal";
        _control sliderSetPosition _value;
    };
};

_thisInfo get "counter" ctrlSetText format["%1", _value];
_thisInfo set["unitCount", _value];

if !(isNil { _control getVariable QGVAR(uiLocked)}) exitWith {};

[CBA_EVENT_DIALOG_UPDATE_PRICETAG, [_group]] call CBA_fnc_localEvent;
[CBA_EVENT_DIALOG_UPDATE_DELTA, [_group]] call CBA_fnc_localEvent;
[CBA_EVENT_DIALOG_UPDATE_SLIDERS, [_control]] call CBA_fnc_localEvent;

nil;
