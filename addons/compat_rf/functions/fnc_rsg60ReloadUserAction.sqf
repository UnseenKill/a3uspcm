#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_compat_rf_fnc_rsg60ReloadUserAction

Description:
    User action to reload RSG-60 mortar

Parameters:
    0: _target - RSG60 object <OBJECT>
    1: _caller - Usually the player <OBJECT>
    2: _actionID - ID of the action being called <NUMBER>
    3: _arguments - Additional arguments <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(rsg60ReloadUserAction),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_caller", nil, [objNull]],
    ["_actionID", nil, [0]],
    ["_arguments", nil, [[]]]
]) exitWith {};

if !assert(!isNull _target) exitWith {};
if !assert(!isNull _caller) exitWith {};
if !assert(_arguments params[
    ["_fakeMagazineName", nil, [""]],
    ["_realMagazineName", nil, [""]],
    ["_magazineMaxCount", nil, [0]],
    ["_magazineDisplayName", nil, [""]],
    ["_reloadTime", nil, [0]]
]) exitWith {};

private _cargo = magazinesAmmoCargo backpackContainer _caller;
private _index = _cargo findIf {
    _x select 0 isEqualTo _fakeMagazineName;
};

if !assert(_index != -1) exitWith { ERROR_1("No ammo of type [%1] in backpack?",_fakeMagazineName); };

private _magazineCount = _cargo select _index select 1;
_reloadTime = _reloadTime * (_magazineCount / _magazineMaxCount);

[
    _reloadTime,
    [_target, _caller, _fakeMagazineName, _realMagazineName, _magazineCount, _magazineDisplayName],
    {
        (_this select 0) params["_target","_caller","_fakeMagazineName","_realMagazineName","_magazineCount","_magazineDisplayName"];
        private _turret = _target unitTurret _caller;

        TRACE_7(QFUNC(rsg60ReloadUserAction),_target,_caller,_fakeMagazineName,_realMagazineName,_magazineCount,_magazineDisplayName,_turret);

        _target addMagazineTurret[_realMagazineName, _turret, _magazineCount];
        backpackContainer _caller addMagazineAmmoCargo[_fakeMagazineName, -1, _magazineCount];
    },
    { ERROR(_this) },
    format[localize "STR_ACE_CSW_loadX", _magazineDisplayName],
    {
        (_this select 0) params["_target","_caller","_fakeMagazineName","","_magazineCount"];
        alive(_target) && { _target isEqualTo objectParent _caller } && 
        // In case somebody reaches into the backpack while reloading...
        { magazinesAmmoCargo backpackContainer _caller findIf { _x isEqualTo [_fakeMagazineName, _magazineCount] } != -1 }
    },
    ["isNotInside"]
] call ace_common_fnc_progressBar;

nil;
