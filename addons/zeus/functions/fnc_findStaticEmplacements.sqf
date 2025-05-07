#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_findStaticEmplacements

Description:
    Make static weapon emplacements in 100m radius of the module editable by the curator.

Parameters:
    0: _logic - module logic object <OBJECT> or Position3DASL <ARRAY>
    1: _units - units affected <ARRAY>
    2: _activated - module activation state <BOOL>

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_logic", objNull, [objNull,[]]],
    ["_units", [], []],
    ["_activated", false, [false]]
];

TRACE_1(QFUNC(findStaticEmplacements),_this);

private _position = if (_logic isEqualType []) then {
    _logic;
} else {
    private _p = getPosATL _logic;

    if (_logic isKindOf "Module_F") then {
        deleteVehicle _logic;
    };

    _p;
};

private _radius = FIND_STATIC_RADIUS;
private _statics = nearestObjects[_position, ["StaticWeapon"], _radius, true] select {
    (alive _x) && { _x isKindOf "StaticWeapon" };
};

allCurators apply {
    _x addCuratorEditableObjects[_statics, true];
};

nil;
