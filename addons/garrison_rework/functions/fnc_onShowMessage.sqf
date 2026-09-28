#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onShowMessage

Description:
    CBA_EVENT_SHOW_MESSAGE event handler

    Display an error (a string or a `format` compatible array), optionally
    as an error based on the `_isError` parameter. Call without arguments to
    reset the displayed message.

Parameters:

Optional:
    0: _message - message to display <STRING,ARRAY>
    1: _isError - whether the message is an error <BOOL> (default: false)

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onShowMessage),_this);

private _message = param[0, nil, ["", []]];
private _isError = param[1, false, [true]];

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _recruitList = _controls get "RecruitList";
private _showControls = isNil "_message";
private _backgroundControl = _recruitList getVariable QUIBVAR(controls) get "#background";

_recruitList getVariable QUIBVAR(controls) apply {
    if (_y isEqualTo _backgroundControl) then {
        _y ctrlShow !_showControls;
    } else {
        _y ctrlShow _showControls;
    };
};

if (_showControls) exitWith {};

if (_message isEqualType []) then {
    _message = format _message;
};

_backgroundControl ctrlSetText _message;
_backgroundControl ctrlSetTextColor([[0.75, 0.75, 0.75, 1], [0.8, 0, 0, 1]] select _isError);

nil;
