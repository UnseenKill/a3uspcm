#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_handle40mmFired

Description:
    40mm grenade "fired" event handler

Parameters:
    0: _unit - Unit that fired the weapon <OBJECT>
    1: _weapon - Weapon that fired the projectile <STRING>
    2: _muzzle - Muzzle that fired the projectile <STRING>
    3: _mode - Mode that fired the projectile <STRING>
    4: _ammo - Ammo that fired the projectile <STRING>
    5: _magazine - Magazine that fired the projectile <STRING>
    6: _projectile - Projectile that was fired <OBJECT>
    7: _vehicle - Vehicle that fired the projectile <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
TRACE_1(QFUNC(handle40mmFired),_this);

if isNull(_projectile) exitWith {};

[_projectile] spawn FUNC(initEmpThrowable);

if (_weapon isEqualTo "Throw") exitWith {};

// HEMTT 1.14.7 complains about "Deflected" not being a valid event handler
// so confuse it until https://github.com/BrettMayson/HEMTT/issues/935 is fixed
GVAR(DeflectedEventName) = ["D","ef","le","ct","ed"] joinString "";

_projectile addEventHandler["Deflected", {
    TRACE_1(QFUNC(handle40mmFired_DeflectEH),_this);
    params[["_projectile",objNull,[objNull]]];
    _projectile removeAllEventHandlers GVAR(DeflectedEventName);
    _projectile removeAllEventHandlers "HitPart";
    [_projectile] remoteExec[QFUNC(empEffect), 2];
}];

_projectile addEventHandler["HitPart", {
    TRACE_1(QFUNC(handle40mmFired_HitPartEH),_this);
    params[["_projectile",objNull,[objNull]]];
    _projectile removeAllEventHandlers GVAR(DeflectedEventName);
    _projectile removeAllEventHandlers "HitPart";
    [_projectile] remoteExec[QFUNC(empEffect), 2];
}];

nil;
