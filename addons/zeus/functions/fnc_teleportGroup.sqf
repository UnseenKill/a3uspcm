#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_teleportGroup

Description:
    Teleport group to cursor position

Parameters:
    0: _position - Right click position from Zeus <ARRAY>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(teleportGroup),_this);

params[
    ["_position",nil,[[]]]
];

private _units = units group theBoss;
private _vehicles = [];

if (player isEqualTo theBoss) then {
    _units apply {
        _vehicles pushBackUnique objectParent _x;
    };
};

_vehicles = _vehicles - [objNull];

private _unmounted = _units - flatten(_vehicles apply { crew _x });
private _positions = [];
private _curpos = _position;

_unmounted = _unmounted select { !isPlayer _x || { _x isEqualTo player } };

{
    private _vpos = if (_foreachIndex == 0) then {
        _curpos findEmptyPosition[5, 10, typeOf _x];
    } else {
        [_curpos, 0, 20, 5] call BIS_fnc_findSafePos;
    };

    if (_vpos isEqualTo []) then {
        systemChat format["No safe position found for %1", getText(configOf _x >> "displayName")];
    } else {
        _curpos = _vpos;

        if (count _curpos isEqualTo 2) then {
            _curpos pushBack 0;
        };

        private _ghost = createVehicle[typeOf _x, [0,0,0], [], 0, "NONE"];
        _ghost allowDamage false;
        _ghost setDir getDir _x;
        _ghost setVectorUp surfaceNormal _curpos;
        _ghost setPosATL _curpos;

        _positions pushBack[_x, _curpos, _ghost];
    };
} forEach(_vehicles + _unmounted);

_positions apply {
    _x params["_vehicle", "_pos", "_ghost"];

    private _vdu = [vectorDir _ghost, vectorUp _ghost];

    deleteVehicle _ghost;

    if (isDamageAllowed _vehicle) then {
        _vehicle allowDamage false;

        [{
            _this allowDamage true;
        }, _vehicle, 3] call CBA_fnc_waitAndExecute;
    };

    _vehicle enableSimulation false;
    _vehicle setVectorDirAndUp _vdu;
    _vehicle setPosATL(_pos vectorAdd[0, 0, [0.5, 0.15] select(_vehicle isKindOf "CAManBase")]);
    _vehicle enableSimulation true;
};

nil;
