#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_updateGarrisonInfo

Description:
    Update location lists' entry's garrison count

Parameters:
    0: _control - location list control <CONTROL>
    1: _index - row-index to update <NUMBER>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
//TRACE_1(QFUNC(updateGarrisonInfo),_this);

if !assert(params[
    ["_control", nil, [controlNull]],
    ["_index", nil, [0]]
]) exitWith {};
if !assert(!isNull _control) exitWith {};

private _entry = _control getVariable QGVAR(entries) select _index;

if !assert(!isNil "_entry") exitWith {};

private _marker = _entry get "marker";

if (sidesX getVariable[_marker, sideUnknown] isNotEqualTo teamPlayer) exitWith {};

private _garrison = garrison getVariable _marker;

if (isNil "_garrison") exitWith { WARNING_2("location #%1 (%2) has no garrison",_index,_marker) };

private _column = 0;

INC(_column);
_control lnbSetText[[_index, _column], str count _garrison];

INC(_column);
_control lnbSetText[[_index, _column], str([_marker] call A3A_fnc_getGarrisonLimit)];

_control getVariable QGVAR(columnsOrder) apply {
    private _unitType = _x;
    private _unitCount = { _x isEqualTo(A3A_faction_reb get _unitType) } count _garrison;

    INC(_column);
    _control lnbSetText[[_index, _column], str _unitCount];
};

nil;
