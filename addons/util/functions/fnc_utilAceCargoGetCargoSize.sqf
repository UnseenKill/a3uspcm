#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilAceCargoGetCargoSize

Description:
    Get constant cargo size of an object

Parameters:
    0: _vehicle - Vehile <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle player] call A3USPCM_fnc_utilAceCargoGetCargoSize;
    (end example)

Returns:
    Cargo space <NUMBER>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith {0};

private _space = _vehicle getVariable["ace_cargo_space", 0];
private _loaded = _vehicle getVariable ["ace_cargo_loaded", []];

_loaded apply {
    _space = _space + ((_x call ace_cargo_fnc_getSizeItem) max 0);
};

_space;
