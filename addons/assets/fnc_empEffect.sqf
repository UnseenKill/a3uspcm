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

nil;
