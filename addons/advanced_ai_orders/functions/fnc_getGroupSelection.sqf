#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_getGroupSelection

Description:
    Get selection from either group selection or RED team assignment

Parameters:
    0: _player - Group leader <OBJECT>

Optional:
    2: _fallbackTeamName - If set, will return RED/BLUE/... team assigned units
        if no group selection is made. Default: "RED" <STRING>

Returns:
    <ARRAY> Array of selected units

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getGroupSelection),_this);

if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith {[]};
if !assert(!isNull _player) exitWith {[]};

private _fallbackTeamName = param[1, "RED", [""]];
private _units = groupSelectedUnits _player;

if (_units isEqualTo [] && { _fallbackTeamName isNotEqualTo "" }) then {
    _units = units group _player select { assignedTeam _x isEqualTo _fallbackTeamName };
};

_units;
