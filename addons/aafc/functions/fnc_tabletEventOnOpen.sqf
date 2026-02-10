#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletEventOnOpen

Description:
    onLoad event handler for CBA_EVENT_AAFC_DIALOG_OPENED event.

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
TRACE_1(QFUNC(tabletEventOnOpen),_this);

if !assert(params[
    ["_display", nil, [displayNull]]
]) exitWith {};

_display setVariable[QGVAR(currentTab), 0];
_display setVariable[QGVAR(tabs), createHashMapFromArray([
    [IDC_BTN_TAB_OVERVIEW, IDC_TABHOST_OVERVIEW],
    [IDC_BTN_TAB_TARGETS, IDC_TABHOST_TARGETS],
    [IDC_BTN_TAB_CONFIGURATION, IDC_TABHOST_CONFIGURATION]
] apply {
    _x params["_idcButton","_idcTabHost"];

    private _ctlButton = _display displayCtrl _idcButton;
    private _ctlTabHost = _display displayCtrl _idcTabHost;

    _ctlTabHost ctrlEnable false;
    _ctlTabHost ctrlSetFade 1;
    _ctlTabHost ctrlShow false;
    _ctlButton setVariable[QGVAR(idcTabHost), _idcTabHost];
    _ctlButton ctrlAddEventHandler["ButtonClick", {
        params["_control"];
        CBA_EVENT_LOCAL(CBA_EVENT_AAFC_DIALOG_TABSWITCH,[_control getVariable QGVAR(idcTabHost)]);
        //[CBA_EVENT_AAFC_DIALOG_TABSWITCH, [_control getVariable QGVAR(idcTabHost)]] call CBA_fnc_localEvent;
    }];

    private _tabHost = createHashMapFromArray[
        ["idc", _idcTabHost],
        ["active", false],
        ["button", _ctlButton],
        ["tabhost", _ctlTabHost]
    ];

    CBA_EVENT_LOCAL(CBA_EVENT_AAFC_DIALOG_TABSETUP,[ARR_3(_display,_ctlTabHost,_tabHost)]);

    [_idcTabHost, _tabHost];
})];
    
[CBA_EVENT_AAFC_DIALOG_TABSWITCH, [IDC_TABHOST_OVERVIEW]] call CBA_fnc_localEvent;

nil;
