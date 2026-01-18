#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_initUtilityItems

Description:
    Initialize the list of utility items available for purchase.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initUtilityItems),_this);

waitUntil {
    (!isNil { missionNamespace getVariable "A3A_utilityItemList" }) &&
    {!isNil { missionNamespace getVariable "A3A_utilityItemHM" }}
};

private _index = (A3A_utilityItemList find(A3A_faction_reb get "lootCrate")) + 1;
private _boxes = [
    [QGVAR(SupplyBoxSmall), 250, LLSTRING(SupplyBoxSmall_DisplayName), "", ["place", "move"]],
    [QGVAR(SupplyBoxMedium), 500, LLSTRING(SupplyBoxMedium_DisplayName), "", ["place", "move"]],
    [QGVAR(SupplyBoxLarge), 1000, LLSTRING(SupplyBoxLarge_DisplayName), "", ["place", "move"]]
];

A3A_utilityItemList insert[_index, _boxes apply {
    if (_x params[["_className", nil, [""]]]) then {
        A3A_utilityItemHM set[_className, _x];
        _className;
    };
}];

nil;
