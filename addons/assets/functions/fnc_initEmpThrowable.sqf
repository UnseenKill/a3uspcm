#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_initEmpThrowable

Description:
    Initialize EMP effect for throwable

Parameters:
    0: _projectile - Projectile to initialize <OBJECT>

Example:
    (begin example)
    [projectile1] call A3USPCM_assets_fnc_initEmpThrowable;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initEmpThrowable),_this);

params[["_projectile",objNull,[objNull]]];

if isNull(_projectile) exitWith {};
[{
    params ["_projectile"];
    if isNull(_projectile) exitWith {};
    [_projectile] remoteExec[QFUNC(empEffect), 2];
}, [_projectile], 3] call CBA_fnc_waitAndExecute;

nil;
