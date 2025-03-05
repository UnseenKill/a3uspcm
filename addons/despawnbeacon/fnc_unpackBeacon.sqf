#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_unpackBeacon

Description:
    Unpack DSB from player inventory

Parameters:
    0: _player - Player object <TYPE>

Optional:

Example:
    (begin example)
    [player] call A3USPCM_despawnbeacon_fnc_unpackBeacon;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(unpackBeacon),_this);

params[
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _player) exitWith {};

[_player, "PutDown"] call ace_common_fnc_doGesture;
[
    1.5,
    [_player],
    {
        params["_params"];
        _params params["_player"];

        _player removeItem QGVAR(PackedBeacon);

        createVehicle[QEGVAR(assets,DespawnSuppressionBeacon), _player modelToWorld[0,1,0], [], 0, "NONE"];
    },
    {},
    localize LSTRING(UnpackingBeaconProgressText)
] call ace_common_fnc_progressBar;

nil;
