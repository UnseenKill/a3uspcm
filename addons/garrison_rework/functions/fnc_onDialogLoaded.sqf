#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onDialogLoaded

Description:
    CBA_EVENT_DIALOG_LOADED event handler

Parameters:
    0: _display - Dialog parent display <DISPLAY>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onDialogLoaded),_this);

if !assert(params[
    ["_display", nil, [displayNull]]
]) exitWith {};
if !assert(!isNull _display) exitWith {};

#define REGISTER_EVENT(Event,Func) (if true then {\
    _display getVariable QGVAR(eventHandlers) pushBack[Event, \
        [Event, Func] call CBA_fnc_addEventHandler \
    ] \
})

uiNamespace setVariable[QGVAR(display), _display];
_display setVariable[QGVAR(eventHandlers), []];

REGISTER_EVENT(CBA_EVENT_DIALOG_BTNCLOSE_CLICK,LINKFUNC(onBtnCloseClick));
REGISTER_EVENT(CBA_EVENT_UPDATE_LOCATIONS,LINKFUNC(updateLocations));
REGISTER_EVENT(CBA_EVENT_UPDATE_LOCATIONS,LINKFUNC(resizeLocations));

nil;
