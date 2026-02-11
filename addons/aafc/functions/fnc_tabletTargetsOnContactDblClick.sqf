#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsOnContactDblClick

Description:
    Double-click handler for contacts list

Parameters:
    0: _control - The control that was double-clicked <CONTROL>
    1: _index - The index of the row that was double-clicked <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsOnContactDblClick),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_index", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};



nil;
