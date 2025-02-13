#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_dumpLoadout

Description:
    ACE action to dump loadout contents to system chat

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>

Optional:
    2: _index - Index of loadout in global array <NUMBER>

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_index", -1, [0]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};
if !assert(!(GVAR(Loadouts) isEqualType false)) exitWith {};

private _lo = GVAR(Loadouts) select _index;

TRACE_1("dump",_lo);

systemChat format["Loadout: %1", _lo select 0];
systemChat format["ACE cargo: %1", _lo select 1 apply { getText(configFile >> "CfgVehicles" >> _x >> "displayName") } joinString ", "];

{
    private _keys = _x select 0 apply {
        [_x, switch true do {
            case isClass(configFile >> "CfgMagazines" >> _x): { getText(configFile >> "CfgMagazines" >> _x >> "displayName") };
            case isClass(configFile >> "CfgWeapons" >> _x): { getText(configFile >> "CfgWeapons" >> _x >> "displayName") };
            case isClass(configFile >> "CfgVehicles" >> _x): { getText(configFile >> "CfgVehicles" >> _x >> "displayName") };
            default { _x };
        }];
    };
    private _values = _x select 1;

    {
        _x params["_key", "_title"];
        systemChat format["%2x %1", _title, _values select _forEachIndex];
    } forEach _keys;
} forEach (_lo select 2);

nil;
