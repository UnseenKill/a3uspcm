#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onUpdateResources

Description:
    CBA_EVENT_UPDATE_RESOURCES event handler

Parameters:

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onUpdateResources),_this);

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _control = _controls get "ResourcesInfo";

_control ctrlSetText format[
    LLSTRING(Dialog_ResourcesInfo_Label),
    [server getVariable "hr", 0, 0, true] call CBA_fnc_formatNumber,
    [server getVariable "resourcesFIA", 0, 0, true] call CBA_fnc_formatNumber,
    A3A_faction_civ get "currencySymbol"
];

nil;
