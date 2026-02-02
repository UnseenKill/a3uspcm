#include "script_component.hpp"

if (isNil "A3A_fnc_traderSellingAppraiseItem") then {
    INFO("Ultimate trader selling appraisal system not detected, skipping hook.");
} else {
    INFO("Hooking into ultimate trader selling appraisal system.");

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
};

nil;
