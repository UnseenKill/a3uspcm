#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_ui_builder_fnc_parseColor

Description:
    Interpret config retrieved array as a color array

Parameters:
    0: _color - color array retrieved from config <ARRAY>

Optional:

Example:

Returns:
    <ARRAY>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(parseColor),_this);

if !assert(params[
    ["_color", nil, [[]], [3, 4]]
]) exitWith {[1, 0, 1, 1]};

_color apply {
    if (_x isEqualType 0) then {
        _x;
    } else {
        [] call compile _x;
    };
};
