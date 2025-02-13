#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilAceCargoLoad

Description:
    Load cargo items into a vehile

Parameters:
    0: _vehicle - Vehicle to load cargo into <OBJECT>
    1: _loader - Player doing the loading <OBJECT>
    2: _items - Classname <STRING> of item or <ARRAY> of classnames to load

Optional:

Example:
    (begin example)
    [cursorTarget, player, "ACE_Wheel"] call A3USPCM_fnc_utilAceCargoLoad;
    (end example)

Returns:
    Success indicator <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_items", [], [[], ""]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if !(_items isEqualType []) then {
    _items = [_items];
};

TRACE_3("load items",_vehicle,_player,_items);

private _index = _items findIf { !([_x, _vehicle] call ace_cargo_fnc_canLoadItemIn) };
private _success = true;

if (_index >= 0) then {
    _success = false;
    WARNING_2("Cannot load item %1 into vehicle %2",_items select _index,_vehicle);
} else {
    _items apply {
        if !([_x, _vehicle] call ace_cargo_fnc_loadItem) then {
            WARNING_2("ACE failed to load item %1 into vehicle %2",_x,_vehicle);
            _success = false;
        };
    };
};

_success;
