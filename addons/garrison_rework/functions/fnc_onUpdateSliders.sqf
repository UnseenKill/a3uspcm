#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onUpdateSliders

Description:
    CBA_EVENT_DIALOG_UPDATE_SLIDERS event handler

    Triggered from changing one unit type slider to updater the remaining
    sliders' new maximum ranges.

Parameters:
    0: _slider - Slider updating <CONTROL>

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
TRACE_1(QFUNC(onUpdateSliders),_this);

if !assert(params[
    ["_slider", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _slider) exitWith {};

private _entry = _slider getVariable QGVAR(entry);
private _group = ctrlParentControlsGroup _slider;
private _garrisonLimit = _entry get "limit";
private _garrisonInfo = _group getVariable QGVAR(garrisonInfo);
private _garrisonCount = [_garrisonInfo, 0, {
    _accumulator + (_y get "unitCount");
}] call CBA_fnc_inject;

_garrisonInfo apply {
    private _info = _y;

    if (_info get "slider" isNotEqualTo _slider) then {
        private _max = _garrisonLimit - _garrisonCount + (_info get "unitCount");
        _info get "slider" sliderSetRange[0, _max max 0];
    };
};

nil;
