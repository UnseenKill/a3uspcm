#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_empEffect

Description:
    EMP effect simulation

Parameters:
    0: _projectile - Projectile to initialize <OBJECT>

Example:
    (begin example)
    [projectile1] call A3USPCM_assets_fnc_empEffect;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(empEffect),_this);

params[["_projectile",objNull,[objNull]]];

if isNull(_projectile) exitWith {};
if (_projectile getVariable[QGVAR(empEffect), false]) exitWith {};

_projectile setVariable[QGVAR(empEffect), true];
[_projectile] remoteExec[QFUNC(empEffectLocal), 0];

private _duration = GVAR(empEffectDuration);
private _range = GVAR(empEffectRangeBlackout);
private _vehDamageRange = GVAR(empEffectRangeVehicleDamage);
private _vehicles = nearestObjects[_projectile, ["Air","LandVehicle","Ship"], _vehDamageRange, false] select { alive _x };
private _groups = [];

_projectile nearObjects["CAManBase", _range] apply {
    _groups pushBackUnique group _x;
};

TRACE_1(QFUNC(empEffect),_groups);
_groups apply {
    _x enableGunLights "ForceOff";
    _x enableIRLasers false;
};

[{
    params["_groups"];

    _groups select { !isNull _x } apply {
        _x enableGunLights "Auto";
        _x enableIRLasers true;
    };
}, [_groups], _duration] call CBA_fnc_waitAndExecute;

{
    private _vehicle = _x;
    private _allHitpoints = getAllHitPointsDamage _vehicle select 0;

    if !(isNil "_allHitpoints") then {
        private _damagePoints = [];
        private _wantEngineDamage = !GVAR(requireVehicleEngineOn) || isEngineOn _vehicle;

        {
            if ((_x find "light" >= 0) || (_wantEngineDamage && (_x find "engine" >= 0))) then {
                _damagePoints pushBack _foreachIndex;
            };
        } forEach _allHitpoints;

        _damagePoints apply { 
            _vehicle setHitIndex[_x, 0.97, true];
        };
    };
} forEach _vehicles;

nil;
