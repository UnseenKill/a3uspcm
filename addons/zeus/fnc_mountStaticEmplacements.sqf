#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_mountStaticEmplacements

Description:
    This module creates a crew and mounts any static emplacements found in the area.

Parameters:
    0: _logic - module logic object <OBJECT>
    1: _units - units affected <ARRAY>
    2: _activated - module activation state <BOOL>

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_logic", objNull, [objNull]],
    ["_units", [], []],
    ["_activated", false, [false]]
];

TRACE_1("A3USPCM_zeus_fnc_mountStaticEmplacements",_this);

private _position = getPosATL _logic;
private _radius = CREW_STATIC_RADIUS;
private _statics = nearestObjects[_position, ["StaticWeapon"], _radius, true] select {
    _x getVariable[QGVAR(crewed), false] isEqualTo false;
};

if (_logic isKindOf "Module_F") then {
    deleteVehicle _logic;
};

if (_statics isEqualTo []) exitWith {
    INFO("No statics found in the area.");
    systemChat localize LSTRING(ModuleMSE_NoStaticsFound);
};

private _group = createGroup independent;

_statics apply {
    crew _x apply { moveOut _x };

    [_group, _x] spawn {
        uiSleep 0.5;
        params["_group","_vehicle"];
        private _unit = _group createUnit["I_crew_F", getPosATL _vehicle, [], 0, "NONE"];
        
        _unit moveInGunner _vehicle;
        _unit setSkill 1;
        _vehicle setVariable[QGVAR(crewed), true, true];
        TRACE_2("Crewed static",_vehicle,_unit);
    };
};

allCurators apply {
    _x addCuratorEditableObjects[_statics, true];
};

nil;
