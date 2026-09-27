#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onLocationSelected

Description:
    CBA_EVENT_DIALOG_LOCATION_SELECTED event handler

Parameters:
    0: _control - The control that triggered the event <CONTROL>
    1: _index - The index of the selected location <SCALAR>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onLocationSelected),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_index", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

if (_index isEqualTo(_control getVariable[QGVAR(currentSelection), -1337])) exitWith {};
_control setVariable[QGVAR(currentSelection), _index];

// Toggle recruitment panel
private _rootControl = _control getVariable QUIBVAR(root);
private _recruitGroup = _rootControl getVariable QUIBVAR(controls) get "RecruitList";
private _recruitControls = _recruitGroup getVariable QUIBVAR(controls);

allControls _recruitGroup apply { _x ctrlEnable (_index >= 0) };

private _entry = _control getVariable QGVAR(entries) select _index;

// Nothing selected or not friendly, exit early
if (_index < 0 || { !(_entry get "friendly") }) exitWith {
    _control setVariable[QGVAR(currentEntry), nil];
    _recruitGroup setVariable[QGVAR(garrisonInfo), nil];

    [CBA_EVENT_UPDATE_DELTA, [0]] call CBA_fnc_localEvent;
    [CBA_EVENT_DIALOG_UPDATE_DELTA, [_recruitGroup]] call CBA_fnc_localEvent;
    [CBA_EVENT_DIALOG_UPDATE_PRICETAG, [_recruitGroup]] call CBA_fnc_localEvent;

    keys _recruitControls select { _x find "Counter_" == 0 } apply {
        _recruitControls get _x ctrlSetText "";
    };
};

_control setVariable[QGVAR(currentEntry), _entry];

TRACE_1(QFUNC(onLocationSelected),_entry);

if !assert(!isNil "_entry") exitWith {};

private _garrison = garrison getVariable(_entry get "marker");

if !assert(!isNil "_garrison") exitWith { [_control, -1] call FUNC(onLocationSelected) };

private _garrisonSize = count _garrison;
private _garrisonInfo = createHashMapFromArray(allControls _recruitGroup select {
    !isNil { _x getVariable QGVAR(unitType) };
} apply {
    private _slider = _x;
    private _unitType = _slider getVariable QGVAR(unitType);
    private _unitCount = { _x isEqualTo(A3A_faction_reb get _unitType) } count _garrison;

    _slider sliderSetRange[0, _unitCount + (_entry get "limit") - _garrisonSize];
    _slider sliderSetPosition _unitCount;
    _slider sliderSetSpeed[1, 1, 1];
    _slider setVariable[QGVAR(entry), _entry];

    private _counter = _recruitControls get format["Counter_%1", _slider getVariable QGVAR(unitName)];

    [_unitType, createHashMapFromArray[
        ["counter", _counter],
        ["slider", _slider],
        ["unitCount", _unitCount],
        ["unitCountOriginal", _unitCount],
        ["unitType", _unitType]
    ]];
});

_recruitGroup setVariable[QGVAR(garrisonInfo), _garrisonInfo];

[CBA_EVENT_DIALOG_UPDATE_DELTA, [_recruitGroup]] call CBA_fnc_localEvent;
[CBA_EVENT_DIALOG_UPDATE_PRICETAG, [_recruitGroup]] call CBA_fnc_localEvent;

_garrisonInfo apply {
    _y get "slider" setVariable[QGVAR(uiLocked), true];
    [CBA_EVENT_DIALOG_UNITTYPE_SLIDER_CHANGED, [_y get "slider", _y get "unitCount"]] call CBA_fnc_localEvent;
    _y get "slider" setVariable[QGVAR(uiLocked), nil];
};

nil;
