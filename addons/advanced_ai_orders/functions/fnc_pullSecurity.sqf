#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_pullSecurity

Description:
    Make selected units pull security depending on a template.

Parameters:
    0: _positionsTemplate - Template description <ARRAY>
    1: _commander - Unit to pull security around <OBJECT>
    2: _units - Units to pull security <ARRAY>
    3: _center - Center position or object <OBJECT/ARRAY>
    4: _distance - Distance to pull security at <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(pullSecurity),_this);

if !assert(params[
    ["_positionsTemplate", nil, [[]]],
    ["_commander", nil, [objNull]],
    ["_units", nil, [[]]],
    ["_center", nil, [objNull, []]],
    ["_distance", nil, [0]]
]) exitWith {};

private["_params"];

if (_center isEqualType objNull && { !assert(!isNull _center)}) exitWith {};
if (_center isEqualType []) then {
    _params = _center;
} else {
    _params = [getPosATL _center, getDir _center];
};

if !assert(_params params[
    ["_position", nil, [[]], 3],
    ["_heading", nil, [0]]
]) exitWith {};

private _sortedUnits = _units apply { [groupId _x, _x] };
_sortedUnits sort true;

private _numUnits = count _sortedUnits;
private _positions = +_positionsTemplate;

_positions sort true;
_positions = (_positions apply {
    if (_sortedUnits isEqualTo []) then { breakWith[] };

    _x params["_degrees","_maxUnitsCount","_minUnitsCount"];

    if ((!isNil "_maxUnitsCount") && { _numUnits > _maxUnitsCount }) then { continueWith[] };
    if ((!isNil "_minUnitsCount") && { _numUnits < _minUnitsCount }) then { continueWith[] };

    private _direction = [_heading + _degrees] call FUNCMAIN(utilNormalizeDirection);

    [_sortedUnits deleteAt 0 select -1, _direction, _center getPos[_distance, _direction]];
}) - [[]];

_positions apply {
    _x params["_unit","_direction","_position"];
    
    if !(isNull _commander) then {
        _commander groupChat format["%1, pull security %2°", name _unit, [_direction, 5] call FUNCMAIN(utilCutNumber)];
    };

    unassignVehicle _unit;

    _unit setVariable[QGVAR(securityPosition), [_position, _direction]];

    [_commander, _unit, _position, _direction] spawn FUNC(assumePosition);
};

nil;
