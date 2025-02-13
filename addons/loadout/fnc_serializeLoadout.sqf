#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_serializeLoadout

Description:
    Save vehicle loadout into storable format

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _loadoutName - Loadout name <STRING>

Optional:

Example:
    (begin example)
    private _serialized = [vehicle player, "Basic"] call FUNC(serializeLoadout);
    (end)

Returns:
    Serialized loadout <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_loadoutName", "", [""]]
];

if !assert(!isNull _vehicle) exitWith { false };

private _bp = getBackpackCargo _vehicle;
private _wc = getWeaponCargo _vehicle;
private _mc = getMagazineCargo _vehicle;
private _ic = getItemCargo _vehicle;

if ((count flatten(_bp + _wc + _mc + _ic)) == 0) exitWith { false };

if (_loadoutName isEqualTo "") then {
    _loadoutName = getText(configOf _vehicle >> "displayName");
};

private _loadout = [
    _loadoutName,
    [_vehicle] call FUNCMAIN(utilAceCargoGetLoaded),
    [_bp, _wc, _mc, _ic]
];

_loadout;
