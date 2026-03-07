#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_reloadCheck

Description:
    Check if the vehicle needs to reload

Parameters:
    0: _vehicle - Vehicle to check <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle player] call A3USPCM_aafc_fnc_reloadCheck;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(reloadCheck),_this);

if !assert(params[
    ["_vehicle", objNull, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

if (_vehicle isKindOf "CAManBase") exitWith {};
if (isNull gunner _vehicle) exitWith {};

private _turret = assignedVehicleRole gunner _vehicle select 1;
private _magazines = magazinesAllTurrets _vehicle select { _x select 1 isEqualTo _turret };
private _weapons = _vehicle weaponsTurret _turret;

TRACE_1(QFUNC(reloadCheck),_magazines);
TRACE_1(QFUNC(reloadCheck),_weapons);

_magazines apply {
    _x params["_magazine","_turret","_count"];

    if (_count == 0) then {
        TRACE_2(QFUNC(reloadCheck),_magazine,_turret);

        _vehicle removeMagazinesTurret[_magazine, _turret];
        _vehicle addMagazineTurret[_magazine, _turret];

        if GVAR(sideChatFired) then {
            private _sender = _vehicle turretUnit _turret;
            private _message = format[
                LLSTRING(Message_Reloading),
                getText(configFile >> "CfgMagazines" >> _magazine >> "displayName")
            ];

            CBA_EVENT_GLOBAL(CBA_EVENT_AAFC_SIDECHAT_FIRED,[ARR_2(_sender,_message)]);
        };
    };
};

nil;
