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

private["_smokeLauncher"];
private _vehicle = objectParent player;
private _turrets = allTurrets[_vehicle, true];
private _index = _turrets findIf {
    _smokeLauncher = -1;
    _vehicle weaponsTurret _x findIf {
        INC(_smokeLauncher);
        toLower _x find "smoke" >= 0
    } >= 0
};

TRACE_2(QFUNCMAIN(fireSmokeLauncher),_index,_smokeLauncher);

if (_index isEqualTo -1) exitWith {};

private _path = _turrets select _index;
private _unit = _vehicle turretUnit _path;

if (isNull _unit) exitWith {};
if (_unit isEqualTo player) exitWith {};

[_vehicle, _vehicle weaponsTurret _path select _smokeLauncher] call BIS_fnc_fire;

nil;
