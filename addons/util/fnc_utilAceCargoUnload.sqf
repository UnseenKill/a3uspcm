#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilAceCargoUnload

Description:
    Unload ACE cargo from vehicle

Parameters:
    0: _vehicle - Vehicle to unload cargo from <OBJECT>
    1: _unloader - Player doing the unloading <OBJECT>
    2: _unloadWheels - Unload and deploy (true) wheels or just unload and discard (false) <BOOL>

Optional:

Example:
    (begin example)
    // Unload all cargo from vehicle, dispose of wheels
    [vehicle player, false] call A3USPCM_fnc_utilAceCargoUnload;

    // Unload all cargo from vehicle, also wheels
    [vehicle player, true] call A3USPCM_fnc_utilAceCargoUnload;
    (end example)

Returns:
    Success indicator for when everything could be unloaded <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_unloadWheels", false, [false]]
];

if !assert(!isNull _vehicle) exitWith { false };

private _unloaded = true;

{
    if (_x in ["ACE_Track","ACE_Wheel"] && !_unloadWheels) then {
        TRACE_2("discard",_vehicle,_x);
        [_x, _vehicle] call ace_cargo_fnc_removeCargoItem;
    } else {
        TRACE_2("unload",_vehicle,_x);
        if !([_x, _vehicle, _player] call ace_cargo_fnc_unloadItem) then {
            WARNING_2("failed to unload %1 from %2",_x,_vehicle);
            _unloaded = false;
        };
    };
} forEach ACE_VEHICLE_CARGO(_vehicle);

_unloaded;
