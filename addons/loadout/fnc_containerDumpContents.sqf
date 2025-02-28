#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_containerDumpContents

Description:
    Dump the contents of a container to the ground

Parameters:
    0: _container - Container object <OBJECT>
    1: _player - Player initiating dump <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget] call A3USPCM_loadout_fnc_containerDumpContents;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(containerDumpContents),_this);

params[
    ["_container", objNull, [objNull]]
];

if !assert(!isNull _container) exitWith {};
if !([_container] call FUNCMAIN(utilVehicleHasCargo)) exitWith { systemChat localize LSTRING(DumpContentsEmpty) };

private _gwh = nearestObjects[_container, ["GroundWeaponHolder"], 10];

if (_gwh isNotEqualTo []) then {
    _gwh = _gwh select 0;
} else {
    _gwh = createVehicle["GroundWeaponHolder", getPosATL _player, [], 1, "CAN_COLLIDE"];
};

TRACE_2(QFUNC(containerDumpContents),_gwh,getPosATL _gwh);

[_container, _gwh] call FUNCMAIN(utilContainerCargoCopy);
playSound3D["x\A3A\addons\core\Sounds\Misc\LootSuccess.ogg", _gwh];

systemChat format[localize LSTRING(DumpContentsSuccess), getText(configOf _container >> "displayName")];

nil;
