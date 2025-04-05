#include "..\script_component.hpp"
#include "..\RscDefine.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_commanderMenuStopWatchesInit

Description:
    Initialize stop watches control group

Parameters:
    0: _groupControl - Control group <CONTROL>
    1: _groupConfig - Controls config <CONFIG>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(commanderMenuStopWatchesInit),_this);

params[
    ["_groupControl",controlNull,[controlNull]],
    ["_groupConfig",configNull,[configNull]]
];

if !assert(!isNull _groupControl) exitWith {};
if !assert(!isNull _groupConfig) exitWith {};

waitUntil { !isNull(uiNamespace getVariable[QGVAR(CommanderMenu), displayNull]) };
private _display = uiNamespace getVariable QGVAR(CommanderMenu);
TRACE_1(QFUNC(commanderMenuStopWatchesInit),_display);

private["_control"];
private _config = _groupConfig >> QGVAR(Config);

if !assert(isClass _config) exitWith {};

private _idc = ctrlIDC _groupControl;
private _index = getNumber(_config >> "timerIndex");
private _timer = GVAR(Timers) select _index;

// That sometimes happens
if (isNil "_timer") then {
    _timer = false;
};

TRACE_4(QFUNC(commanderMenuStopWatchesInit),str _groupControl,_idc,_index,_timer);

if (_timer isEqualTo false) then {
    _control = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_SLIDER);
    _control ctrlShow true;
    _control ctrlAddEventHandler["SliderPosChanged", {
        params[["_control",controlNull,[controlNull]], ["_value",0,[0]]];

        private _idc = (ctrlIDC _control) - CMI_OFFSET_STOPWATCH_SLIDER;
        private _display = uiNamespace getVariable QGVAR(CommanderMenu);
        private _textCtrl = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_TEXT);

        _value = round _value;

        TRACE_3("slider changed",_control,_value,_textCtrl);

        _textCtrl ctrlSetText format[localize LSTRING(CMI_IDC_CM_INJECT_STOPWATCHES_TEXT), _value, [_value * 60, "HH:MM"] call BIS_fnc_secondsToString];
    }];
    _control sliderSetRange[0, 600];
    _control sliderSetPosition 60;

    _control = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_PROGRESS);
    _control ctrlShow false;
} else {
    _control = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_SLIDER);
    _control ctrlShow false;

    private _progress = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_PROGRESS);
    _progress ctrlShow true;

    _control = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_TEXT);

    [_index, _timer, _control, _progress] spawn {
        params[["_index",nil,[0]], ["_timer",nil,[createHashMap]], ["_control",nil,[controlNull]], ["_progressCtrl",nil,[controlNull]]];

        TRACE_1(QFUNC(commanderMenuStopWatchesInit_UPDATELOOP_START),_index);

        while { true } do {
            if isNull(uiNamespace getVariable[QGVAR(CommanderMenu), displayNull]) then { break };
            if (GVAR(Timers) select _index isEqualTo false) then { break };

            private _now = dateToNumber date;
            private _start = _timer get "start";
            private _dateExpired = _timer get "dateExpired";
            private _unit = (dateToNumber[_timer get "year", 1, 1, 0, 1]) - (dateToNumber[_timer get "year", 1, 1, 0, 0]);

            private _remaining = (_dateExpired - _now) / _unit * 60;
            private _progress = linearConversion[_start, _dateExpired, _now, 0, 1];
            _progressCtrl progressSetPosition _progress;

            _control ctrlSetText format["Timer expires in about %1", [_remaining, "HH:MM"] call BIS_fnc_secondsToString];
            uiSleep 0.5;
        };

        TRACE_1(QFUNC(commanderMenuStopWatchesInit_UPDATELOOP_END),_index);
    };
};

_control = _display displayCtrl (_idc + CMI_OFFSET_STOPWATCH_BUTTON);
_control setVariable[QGVAR(timerIndex), _index];
_control setVariable[QGVAR(groupControl), _groupControl];
_control setVariable[QGVAR(groupConfig), _groupConfig];
_control ctrlSetText localize([LSTRING(CMI_IDC_CM_INJECT_STOPWATCHES_START), LSTRING(CMI_IDC_CM_INJECT_STOPWATCHES_STOP)] select (_timer isNotEqualTo false));
_control ctrlAddEventHandler["ButtonClick", {
    call FUNC(commanderMenuStopWatchToggle);
}];

nil;
