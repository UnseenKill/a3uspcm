#include "..\script_component.hpp"
#include "..\RscDefine.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_commanderMenuInit

Description:
    Initialize controls of A3USPCM injected commander menu tab

Parameters:
    0: _control - tab control <CONTROL>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(commanderMenuInit),_this);

params[
    ["_control",controlNull,[controlNull]]
];

waitUntil { !isNull findDisplay IDD_COMMANDER_MENU };

private _display = findDisplay IDD_COMMANDER_MENU;
TRACE_1(QFUNC(commanderMenuInit),_display);

if !assert(!isNull _control) exitWith {};

uiNamespace setVariable[QGVAR(CommanderMenu), _display];

private _controls = createHashMap;

allControls _control apply {
    // For some fucking reason, IDCs above an unknown magnitude are stringified in +e notation; no way around this but to parse the _actual_ stringified version which returns the correct IDC
    private _str = str _x;
    private _idc = _str select [9];

    if (_idc isNotEqualTo "-1") then {
        TRACE_2(QFUNC(commanderMenuInit),_x,_idc);
        _x ctrlSetFade 0;
        _x ctrlCommit 0.3;
        _controls set[_idc, _x];
    };
};

TRACE_1(QFUNC(commanderMenuInit),_controls);

private _shortcuts = [];

"true" configClasses (configFile >> QGVAR(Config) >> "Diary") apply {
    "getNumber(_x >> 'cmShortcut') > 0" configClasses _x apply {
        _shortcuts pushBack _x;
    };
};

TRACE_1(QFUNC(commanderMenuInit),_shortcuts);
GVAR(cmShortcuts) = createHashMap;

if (count _shortcuts > MAX_CM_SHORTCUTS) then {
    WARNING_1("Too many shortcuts defined in config. Only first %1 will be used.",MAX_CM_SHORTCUTS);
    _shortcuts = _shortcuts select [0, MAX_CM_SHORTCUTS - 1];
};

while { count _shortcuts < MAX_CM_SHORTCUTS } do {
    _shortcuts pushBack configNull;
};

TRACE_1(QFUNC(commanderMenuInit),_shortcuts);

{
    private _idc = format["%1%2",QUOTE(IDC_CM_INJECT_HOTBUTTONS_BASE),_forEachIndex];
    private _config = _x;
    private _control = _controls getOrDefault[_idc, controlNull];

    TRACE_2(QFUNC(commanderMenuInit),_idc,_control);

    if !assert(!isNull _control) then { continue };

    if isNull(_config) then {
        _control ctrlShow false;
        GVAR(cmShortcuts) set[_idc, false];
    } else {
        _control ctrlSetText getText(_config >> "caption");
        _control ctrlSetTooltip getText(_config >> "text");
        GVAR(cmShortcuts) set[_idc, [getText(_config >> "action"), _config]];
    };
} forEach _shortcuts;

TRACE_1(QFUNC(commanderMenuInit),GVAR(cmShortcuts));

nil;
