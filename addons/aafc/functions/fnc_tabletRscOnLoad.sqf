#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletRscOnOpen

Description:
    onLoad event handler coded into Rsc class.

Parameters:
    0: _display - Tablet display <DISPLAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletRscOnOpen),_this);

if !assert(params[
    ["_display", nil, [displayNull]]
]) exitWith {};

uiNamespace setVariable[QGVAR(events), []];

CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_OPENED,{call FUNC(tabletEventOnOpen)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TABSETUP,{call FUNC(tabletOverviewSetup)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TABSETUP,{call FUNC(tabletTargetsSetup)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TABSWITCH,{call FUNC(tabletEventOnSwitchTab)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE,{call FUNC(tabletOverviewFocus)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE,{call FUNC(tabletTargetsFocus)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_AFTER,{call FUNC(tabletEventOnAfterTabFocus)});
CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_BEFORE,{call FUNC(tabletTargetsUnfocus)});

CBA_UI_SUBSCRIBE(CBA_EVENT_AAFC_SET_ROE_GLOBAL,{call FUNC(tabletOverviewUpdate)});

uiNamespace setVariable[QGVAR(display), _display];
CBA_EVENT_LOCAL(CBA_EVENT_AAFC_DIALOG_OPENED,[_display]);

nil;
