#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_fireSmokeLauncher

Description:
    Fire smoke launcher of the vehicle even if not commander.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_fireSmokeLauncher;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(fireSmokeLauncher),_this);

if (isNull objectParent player) exitWith {};

private _vehicle = vehicle player;
private _commander = commander _vehicle;

if (_commander isEqualTo player) exitWith {};

private _turret = _vehicle unitTurret _commander;
private _turretWeapons = _vehicle weaponsTurret _turret;
private _index = _turretWeapons findIf { toLower _x find "smoke" >= 0 };

if (_index >= 0) then {
    [_vehicle, _turretWeapons select _index] call BIS_fnc_fire;
};

nil;
