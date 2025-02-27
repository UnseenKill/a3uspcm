#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilContainerCargoCopy

Description:
    Copy the contents of one container to another

Parameters:
    0: _source - Source container <OBJECT>
    1: _dest - Destination container <OBJECT>

Optional:
    2: _keepSource - Whether to clear contents of source after copy (false) <BOOL>

Example:
    (begin example)
    [obj1, obj2] call A3USPCM_fnc_utilContainerCargoCopy;
    (end example)

Returns:
    If anything was copied <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_source", objNull, [objNull]],
    ["_dest", objNull, [objNull]],
    ["_keepSource", false, [false]]
];

if !assert(!isNull _source) exitWith { false };
if !assert(!isNull _dest) exitWith { false };
if !([_source] call FUNCMAIN(utilVehicleHasCargo)) exitWith { false };

private _items = getItemCargo _source;
_items params["_itmNames", "_itmCount"];
for "_n" from 0 to count(_itmNames) - 1 do {
	_dest addItemCargoGlobal[_itmNames select _n, _itmCount select _n];
};

magazinesAmmoCargo _source apply {
	_x params["_magName", "_magAmmo"];
	_dest addMagazineAmmoCargo[_magName, 1, _magAmmo];
};

weaponsItemsCargo _source apply {
	_dest addWeaponWithAttachmentsCargoGlobal[_x, 1];
};

backpackCargo _source apply {
	_dest addBackpackCargoGlobal[_x, 1];
};

if !_keepSource then {
	clearBackpackCargoGlobal _source;
	clearItemCargoGlobal _source;
	clearMagazineCargoGlobal _source;
	clearWeaponCargoGlobal _source;
};

true;
