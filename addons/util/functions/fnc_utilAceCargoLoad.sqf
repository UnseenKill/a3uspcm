#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilAceCargoLoad

Description:
    Load cargo items into a vehile

Parameters:
    0: _vehicle - Vehicle to load cargo into <OBJECT>
    1: _loader - Player doing the loading <OBJECT>
    2: _items - Classname <STRING> of item or <ARRAY> of classnames to load

Optional:
    3: _requireItemPresence - Require item to be present around vehicle (default: true) <BOOL>

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
    ["_items", [], [[], ""]],
    ["_requireItemPresence", true, [true]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };
if !EGVAR(main,AceHaveAddon) exitWith { true };

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
    private _nearItems = if !_requireItemPresence then [{ [] }, { nearestObjects[_vehicle, _items, ACE_CARGO_LOAD_RADIUS] }];
    TRACE_1("near items",_nearItems);

    {
        private _item = _x;

        if (_requireItemPresence) then {
            _index = _nearItems findIf {
                (isNull attachedTo _x) && 
                { typeOf _x isEqualTo _item } &&
                { crew _x isEqualTo [] }
            };

            if (_index < 0) then {
                WARNING_2("No unattached %1 around %2 meters of vehicle",_item,ACE_CARGO_LOAD_RADIUS);
                throw [format[localize LSTRING(ACELoadNoEntityNear), getText(configFile >> "CfgVehicles" >> _item >> "displayName"), ACE_CARGO_LOAD_RADIUS]];
            };

            _item = _nearItems deleteAt _index;
#ifdef ACE_CARGO_CONVERT_TO_CLASS
            deleteVehicle _item;
            _item = _x;
#endif
        };

        if !([_item, _vehicle] call ace_cargo_fnc_loadItem) then {
            WARNING_2("ACE failed to load item %1 into vehicle %2",_item,_vehicle);
            _success = false;
        };
    } forEach _items;
};

_success;
