#include "..\script_component.hpp"
#include "..\RscDefine.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_commanderMenuStopWatchToggle

Description:
    Start/stop a stop watch

Parameters:
    0: _buttonControl - Button initiating the toggle event <TYPE>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(commanderMenuStopWatchToggle),_this);

params[
    ["_buttonControl",controlNull,[controlNull]]
];

if !assert(!isNull _buttonControl) exitWith {};

private _display = uiNamespace getVariable QGVAR(CommanderMenu);
private _index = _buttonControl getVariable QGVAR(timerIndex);
private _groupControl = _buttonControl getVariable QGVAR(groupControl);
private _groupConfig = _buttonControl getVariable QGVAR(groupConfig);
private _timer = GVAR(Timers) select _index;

if (_timer isNotEqualTo false) then {
    [_timer] call FUNC(timerStop);
    _timer = false;
} else {
    private _slider = _display displayCtrl ((ctrlIDC _groupControl) + CMI_OFFSET_STOPWATCH_SLIDER);
    private _value = sliderPosition _slider;

    _value = round _value;

    TRACE_2(QFUNC(commanderMenuStopWatchToggle),_slider,_value);

    _timer = [_value] call FUNC(timerCreate);
    [_timer] call FUNC(timerStart);
};

GVAR(Timers) set [_index, _timer];
[_groupControl, _groupConfig] call FUNC(commanderMenuStopWatchesInit);

nil;
