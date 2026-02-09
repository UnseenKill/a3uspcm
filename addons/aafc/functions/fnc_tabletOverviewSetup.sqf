#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletOverviewSetup

Description:
    Runs once to set up tab info hashmap. Triggered by CBA_EVENT_AAFC_DIALOG_TABSETUP.

Parameters:
    0: _display - A/A FC UI display <DISPLAY>
    1: _ctlTabHost - Any tab host <CONTROL>
    2: _tabHost - Tab host info hash map <HASHMAP>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletOverviewSetup),_this);

if !assert(params[
    ["_display", nil, [displayNull]],
    ["_ctlTabHost", nil, [controlNull]],
    ["_tabHost", nil, [createHashMap]]
]) exitWith {};

if (IDC_TABHOST_OVERVIEW isNotEqualTo ctrlIDC _ctlTabHost) exitWith {};

[
    ["btnFireAtWill", IDC_OVERVIEW_BTN_FIREATWILL],
    ["btnCIWSOnly", IDC_OVERVIEW_BTN_CIWSONLY],
    ["btnSRSAM", IDC_OVERVIEW_BTN_SRSAM],
    ["btnLRSAM", IDC_OVERVIEW_BTN_LRSAM],
    ["btnHoldFire", IDC_OVERVIEW_BTN_HOLDFIRE],
    ["ctlGroupsHost", IDC_OVERVIEW_HOSTCTL_GROUPS]
] apply {
    _x params["_varName","_idc"];

    private _button = _ctlTabHost controlsGroupCtrl _idc;
    _tabHost set[_varName, _button];
};

nil;
