#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_store_fnc_sellItem

Description:
    Sell item

Parameters:
    0: _class - class <STRING>
    1: _amount - amount <NUMBER>
    2: _price - price <NUMBER>
    3: _itemIndex - item index <NUMBER>
    4: _items - items <ARRAY>
    5: _container - container <OBJECT>

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(sellItem),_this);

params[
    ["_class","",[""]],
    ["_amount",0,[0]],
    ["_price",0,[0]],
    ["_itemIndex",0,[0]],
    ["_items",[],[]],
    ["_container",objNull,[objNull]]
];

private _item = _items select _itemIndex;
private _class = _item get "class";
private _type = _item get "type";
private _count = _item get "count";
private _payout = _price * _amount;

TRACE_4(QFUNC(sellItem),_class,_type,_amount,_payout);

switch _type do {
    case "backpack": { _container addBackpackCargoGlobal[_class, -_amount] };
    case "item": { _container addItemCargoGlobal[_class, -_amount] };
    case "magazine": { _container addMagazineCargoGlobal[_class, -_amount] };
    case "weapon": { _container addWeaponCargoGlobal[_class, -_amount] };
    default { throw "This is where I give up." };
};

traderX say3D QEGVAR(assets,Sell);
[0, _payout] remoteExec ["A3A_fnc_resourcesFIA",2];

if (_amount >= _count) then {
    _items set[_itemIndex, nil];
    true;
} else {
    _items select _itemIndex set["count", _count - _amount];
    false;
};

nil;
