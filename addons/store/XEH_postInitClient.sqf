#include "script_component.hpp"

INFO_2("%1(): %2",QFUNC(XEH_postInitClient),RETNIL(A3A_fnc_traderSellingAppraiseItem));

[{
    if !assert(params[
        ["_itemClass", nil, [""]],
        ["_itemConfig", nil, [configNull]],
        ["_itemType", nil, [""]]
    ]) exitWith {};

    if isNumber(_itemConfig >> QGVAR(fallbackSellPrice)) exitWith {
        getNumber(_itemConfig >> QGVAR(fallbackSellPrice));
    };
}] call A3A_fnc_traderSellingAppraiseItem;

nil;
