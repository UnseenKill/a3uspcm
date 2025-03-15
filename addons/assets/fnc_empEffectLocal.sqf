#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_empEffectLocal

Description:
    EMP effect simulation for local client

Parameters:
    0: _projectile - Projectile to initialize <OBJECT>

Example:
    (begin example)
    [projectile1] call A3USPCM_assets_fnc_empEffectLocal;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(empEffectLocal),_this);

params[["_projectile",objNull,[objNull]]];

private _flame = "#particlesource" createVehicleLocal getPosATL _projectile;
_flame setParticleClass QGVAR(EmpEffect);
_flame attachTo [_projectile, [0, 0, 0]];
[{
    params["_projectile", "_flame"];

    attachedObjects _projectile apply {
        detach _x;
        deleteVehicle _x;
    };

    deleteVehicle _projectile;
}, [_projectile, _flame], 1.75] call CBA_fnc_waitAndExecute;

playSound3D["\z\a3uspcm\addons\assets\sound\emp-blast.ogg", _projectile, false, getPosASL _projectile, 16];
[getPosASL _projectile] call FUNC(blackout);

nil;
