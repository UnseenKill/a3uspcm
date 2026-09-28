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

missionNamespace setVariable[QGVAR(agmInUse), name player, true];

uiNamespace setVariable[QGVAR(display), _display];
_display setVariable[QGVAR(eventHandlers), []];

REGISTER_EVENT(CBA_EVENT_DIALOG_BTNCLOSE_CLICK,LINKFUNC(onBtnCloseClick));
REGISTER_EVENT(CBA_EVENT_DIALOG_BTNRECRUIT_CLICK,LINKFUNC(onBtnRecruitClick));
REGISTER_EVENT(CBA_EVENT_DIALOG_FILTER_CHANGED,LINKFUNC(onDialogFilterChanged));
REGISTER_EVENT(CBA_EVENT_DIALOG_LOCATION_DBLCLICK,LINKFUNC(onLocationDblClick));
REGISTER_EVENT(CBA_EVENT_DIALOG_LOCATION_SELECTED,LINKFUNC(onLocationSelected));
REGISTER_EVENT(CBA_EVENT_DIALOG_UNITTYPE_SLIDER_CHANGED,LINKFUNC(onUnitTypeSliderChanged));
REGISTER_EVENT(CBA_EVENT_DIALOG_UPDATE_DELTA,LINKFUNC(onUpdateDelta));
REGISTER_EVENT(CBA_EVENT_DIALOG_UPDATE_PRICETAG,LINKFUNC(onUpdatePriceTag));
REGISTER_EVENT(CBA_EVENT_DIALOG_UPDATE_SLIDERS,LINKFUNC(onUpdateSliders));

REGISTER_EVENT(CBA_EVENT_RELOAD_LOCATION,LINKFUNC(onReloadLocation));
REGISTER_EVENT(CBA_EVENT_SHOW_MESSAGE,LINKFUNC(onShowMessage));
REGISTER_EVENT(CBA_EVENT_TOGGLE_INTERACTION,LINKFUNC(onToggleInteraction));
REGISTER_EVENT(CBA_EVENT_TERMINATE_UI,LINKFUNC(onTerminateUI));
REGISTER_EVENT(CBA_EVENT_UPDATE_DELTA,LINKFUNC(onBroadcastDelta));
REGISTER_EVENT(CBA_EVENT_UPDATE_LOCATIONS,LINKFUNC(onUpdateLocations));
REGISTER_EVENT(CBA_EVENT_UPDATE_LOCATIONS,LINKFUNC(onResizeLocations));

_display setVariable[QGVAR(filters), missionNamespace getVariable[QGVAR(filters), [FILTER_TOWNS, FILTER_OWNER_REBELS, FILTER_AT_CAPACITY]]];

nil;
