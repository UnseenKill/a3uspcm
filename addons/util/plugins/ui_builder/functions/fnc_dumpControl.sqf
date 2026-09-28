#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_dumpControl

Description:
    Dump control and children to RPT

Parameters:
    0: _control - control to be dumped <CONTROL>

Optional:

Example:
    (begin example)
    [_control] call A3USPCM_util_ui_builder_fnc_dumpControl;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(dumpControl),_this);

#define MAX_WIDTH 190
#define UI_GRID_W (0.025 * safeZoneW)
#define UI_GRID_H (0.025 * safeZoneH)

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};

[{
    private _dump = {
        params["_control",["_level", -1]];
        private _padding = "";
        for "_i" from 0 to _level do {
            _padding = _padding + "    ";
        };

        private _class = _control getVariable QUIBVAR(createClass);
        private _position = ctrlPosition _control;
        private _type = ctrlType _control;

        _position set[0, (_position select 0) / UI_GRID_W];
        _position set[1, (_position select 1) / UI_GRID_H];
        _position set[2, (_position select 2) / UI_GRID_W];
        _position set[3, (_position select 3) / UI_GRID_H];
        _position = _position apply { [_x, 1, 3] call CBA_fnc_formatNumber };
        _position = str _position;

        private _line = _padding + format["%1(%2)", _class, _type];
        private _padToLength = MAX_WIDTH - count _position;

        if (ctrlIDC _control isNotEqualTo -1) then {
            _line = _line + format[" idc=%1", ctrlIDC _control];
        };

        if (_type in [CT_STATIC, CT_BUTTON, CT_EDIT]) then {
            _line = _line + format[" text=%1", str ctrlText _control];
        };

        while { count(_line) < _padToLength } do {
            _line = _line + " ";
        };
        _line = _line + _position;

        diag_log text _line;

        if (CT_CONTROLS_GROUP isEqualTo _type) then {
            allControls _control apply {
                if (_control isEqualTo ctrlParentControlsGroup _x) then {
                    [_x, _level + 1] call _dump;
                };
            };
        };
    };

    diag_log text ">>>-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
    call _dump;
}, [_control], 5] call CBA_fnc_execAfterNFrames;

nil;
