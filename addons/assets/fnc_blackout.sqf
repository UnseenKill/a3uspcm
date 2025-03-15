#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_blackout

Description:
    EMP blackout simulation

Parameters:
    0: _position - Center of effect <ARRAY>

Optional:

Example:
    (begin example)
    [getPos player] call A3USPCM_assets_fnc_blackout;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(blackout),_this);

params[
    ["_position",[],[[]]]
];

private _duration = GVAR(empEffectDuration);
private _range = GVAR(empEffectRangeBlackout);
private _vehDamageHitpoints = ["hitengine"];
private _vehDamageRange = GVAR(empEffectRangeVehicleDamage);
private _vehEngineOn = GVAR(requireVehicleEngineOn);

private _lights = _position nearObjects["Lamps_base_F", _range];
private _vehicles = _position nearObjects["LandVehicle", _vehDamageRange] select { alive _x && (!_vehEngineOn || isEngineOn _x) };

if isClass(configFile >> "CfgPatches" >> "gm_core") then {
    _lights = _lights + (_position nearObjects["gm_lamp_euro_80_base", _range]);
};

_lights = _lights select { (alive _x) && (_x getVariable[GVAR(EmpEffect), false] isEqualTo false) };

{
    private _vehicle = _x;
    {
        _vehicle setHitPointDamage[_x, 1, true];
    } forEach _vehDamageHitpoints;
} forEach _vehicles;

if (_lights isEqualTo []) exitWith {};

_lights apply {
    _x setVariable[GVAR(EmpEffect), false];
    [_x, 0.25, "OFF"] call FUNCMAIN(utilLightFlicker);
};

[{
    params["_lights"];

    _lights apply {
        _x setVariable[GVAR(EmpEffect), nil];
        [_x] spawn {
            params["_light"];
            uiSleep ((random 100) / 100);
            [_light, 0.5] call FUNCMAIN(utilLightFlicker);
        };
    };
}, [_lights], _duration] call CBA_fnc_waitAndExecute;

nil;
