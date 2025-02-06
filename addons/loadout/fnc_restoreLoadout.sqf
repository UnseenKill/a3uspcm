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

{
    TRACE_2("backpack",_x,_y);
    _vehicle addBackpackCargoGlobal[_x, _y];
} forEach ((_backpacks # 0) createHashMapFromArray (_backpacks # 1));

{
    TRACE_2("weapon",_x,_y);
    _vehicle addWeaponCargoGlobal[_x, _y];
} forEach ((_weapons # 0) createHashMapFromArray (_weapons # 1));

{
    TRACE_2("magazine",_x,_y);
    _vehicle addMagazineCargoGlobal[_x, _y];
} forEach ((_magazines # 0) createHashMapFromArray (_magazines # 1));

{
    TRACE_2("item",_x,_y);
    _vehicle addItemCargoGlobal[_x, _y];
} forEach ((_items # 0) createHashMapFromArray (_items # 1));

[
    localize LSTRING(HintLoadoutRestoreCaption),
    format[localize LSTRING(HintLoadoutRestoredText), _title]
] call A3A_fnc_customHint;

nil;
