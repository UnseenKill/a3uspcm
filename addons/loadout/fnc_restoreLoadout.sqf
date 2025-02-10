#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_restoreLoadout

Description:
    ACE action to restore a saved loadout

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>
    2: _loadout - Loadout to restore <ARRAY>

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1("A3USPCM_Loadout_fnc_restoreLoadout",_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_loadout", [], [[]]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};
if !assert(count _loadout > 0) exitWith {};

clearBackpackCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

_loadout params["_title","_backpacks","_weapons","_magazines","_items"];

TRACE_1("_backpacks",_backpacks);
TRACE_1("_weapons",_weapons);
TRACE_1("_magazines",_magazines);
TRACE_1("_items",_items);

private _messages = [];

{
    _x params["_type","_items","_callback"];

    {
        private _index = _x call jn_fnc_arsenal_itemType;
        private _arsenal = jna_datalist select _index;
        private _count = [_arsenal, _x] call jn_fnc_arsenal_itemCount;

        TRACE_3(_type,_index,_x,_count);

        if (_count < 0) then {
            [_vehicle, _x, _y] call _callback;
        } else {
            if (_count == 0) then {
                _messages pushBack format[localize LSTRING(HintLoadoutItemMissingText), _x];
            } else {
                if (_y > _count) then {
                    _y = _count;
                    _messages pushBack format[localize LSTRING(HintLoadoutItemExcessText), _x, _y - _count];
                };

                [_vehicle, _x, _y] call _callback;
                [_index, _x, _y] call jn_fnc_arsenal_removeItem;
            };
        };
    } forEach ((_items # 0) createHashMapFromArray (_items # 1));
} forEach [
    ["backpack", _backpacks, { params["_vehicle","_item","_count"]; _vehicle addBackpackCargoGlobal[_item,_count]; }],
    ["weapon", _weapons, { params["_vehicle","_item","_count"]; _vehicle addWeaponCargoGlobal[_item,_count]; }],
    ["magazine", _magazines, { params["_vehicle","_item","_count"]; _vehicle addMagazineCargoGlobal[_item,_count]; }],
    ["item", _items, { params["_vehicle","_item","_count"]; _vehicle addItemCargoGlobal[_item,_count]; }]
];

[
    localize LSTRING(HintLoadoutRestoreCaption),
    format[localize LSTRING(HintLoadoutRestoredText), _title, getText(configOf _vehicle >> "displayName")]
] call A3A_fnc_customHint;

_messages apply { systemChat _x };

nil;
