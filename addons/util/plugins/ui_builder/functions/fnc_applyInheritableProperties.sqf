#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_applyInheritableProperties

Description:
    Apply common properties to element/controls group

Parameters:
    0: _control - control to apply properties to <CONTROL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyInheritableProperties),_this);

if !assert(params[
    ["_control", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _config = _control getVariable QGVAR(config);

[_control, _config, "font", QGVAR(font), "RobotoCondensed", false] call FUNC(applyInheritableProperty);
[_control, _config, "fontSize", QGVAR(fontSize), 0] call FUNC(applyInheritableProperty);
[_control, _config, "padding", QGVAR(padding), [0,0], true, true] call FUNC(applyInheritableProperty);
[_control, _config, "spacing", QGVAR(spacing), [0,0], true, true] call FUNC(applyInheritableProperty);

nil;
