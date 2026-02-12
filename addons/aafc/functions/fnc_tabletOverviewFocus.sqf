#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletOverviewFocus

Description:
    Runs everytime, the overview tab is focused. Triggered by CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE.

Parameters:
    0: _tabFocused - Tab host gaining focus info hash map <HASHMAP>

Optional:
    1: _tabUnfocused - Tab host losing focus info hash map <HASHMAP>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_tabFocused", nil, [createHashMap]]
]) exitWith {};

if (_tabFocused get "idc" isNotEqualTo IDC_TABHOST_OVERVIEW) exitWith {};

TRACE_1(QFUNC(tabletOverviewFocus),_this);

CBA_EVENT_LOCAL(CBA_EVENT_AAFC_SET_ROE_GLOBAL,[GVAR(globalROE)]);

nil;
