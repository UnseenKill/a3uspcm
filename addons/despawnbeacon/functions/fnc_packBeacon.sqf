#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_packBeacon

Description:
    Pack beacon interacted with

Parameters:
    0: _beacon - beacon object <TYPE>

Optional:

Example:
    (begin example)
    [var1] call A3USPCM_despawnbeacon_fnc_packBeacon;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(packBeacon),_this);

params[
    ["_beacon",objNull,[objNull]],
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith {};
if !assert(!isNull _player) exitWith {};

[_player, "MedicOther"] call ace_common_fnc_doGesture;
[
    5,
    [_beacon, _player],
    {
        params["_params"];
        _params params["_beacon", "_player"];

        private _gwh = createVehicle["GroundWeaponHolder", getPosATL _beacon, [], 0, "CAN_COLLIDE"];
        deleteVehicle _beacon;
        _gwh addItemCargoGlobal[QGVAR(PackedBeacon), 1];
    },
    {},
    localize LSTRING(PackingBeaconProgressText)
] call ace_common_fnc_progressBar;

nil;
