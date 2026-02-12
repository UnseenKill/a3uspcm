#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsCreateMapControl

Description:
    Create/return contacts map control.

Parameters:
    0: _display - Display to create map control on <DISPLAY>
    1: _mapPosition - Map control position <ARRAY>
    2: _mapSize - Map control size <ARRAY> 

Optional:

Returns:
    <CONTROL> Map control for contacts tab.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsCreateMapControl),_this);

if !assert(params[
    ["_display", nil, [displayNull]],
    ["_mapPosition", nil, [[]]],
    ["_mapSize", nil, [[]]]
]) exitWith {};
if !assert(!isNull _display) exitWith {};

INFO("Setting up map control for targets tab");

private _ctlMap  = _display ctrlCreate[QGVAR(RscMapControl), IDC_TARGETS_CTL_MAP];
_ctlMap ctrlSetPosition[_mapPosition select 0, _mapPosition select 1, _mapSize select 0, _mapSize select 1];
_ctlMap ctrlSetBackgroundColor [0,0.15,0,1];
_ctlMap ctrlCommit 0;
_ctlMap ctrlMapSetPosition [];

_ctlMap;
