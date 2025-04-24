#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_handlerSupportTentKilled

Description:
    Event handler for support tents (server side)

Parameters:
    0: _tent - Support tent object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerSupportTentKilled),_this);

params[
    ["_tent",objNull,[objNull]]
];

if !assert(!isNull _tent) exitWith {};

private _supportType = getText(configOf _tent >> QGVAR(supportType));

INFO_2("Support tent '%1' killed; revoking %2 support",getText(configOf _tent >> "displayName"),_supportType);

private _module = [_supportType] call FUNC(getSupportModule);

synchronizedObjects _module apply {
    TRACE_1(QFUNC(handlerSupportTentKilled_synchronizedObjects),_x);
    _module synchronizeObjectsRemove[_x];
};

nil;
