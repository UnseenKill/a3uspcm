#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilUnlockArsenalItem

Description:
    Unlocks the specified item of equipment for use in the arsenal.

Parameters:
    0: _className - Item class to unlock <STRING>

Optional:

Example:
    (begin example)
    ["ACE_painkillers"] call A3USPCM_fnc_utilUnlockArsenalItem;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_className", "", [""]]
];

TRACE_1(QFUNCMAIN(utilUnlockArsenalItem),_className);

private _index = _className call jn_fnc_arsenal_itemType;
private _arsenal = jna_datalist select _index;
private _count = [_arsenal, _className] call jn_fnc_arsenal_itemCount;

private _message = if (_count < 0) then {
    LSTRING(ArsenalItemNotUnlocked);
} else {
    private _result = [_className] call A3A_fnc_unlockEquipment;
    TRACE_1(QFUNCMAIN(utilUnlockArsenalItem),_result);
    LSTRING(ArsenalItemUnlocked);
};

private _caption = switch true do {
    case isText(configFile >> "CfgMagazines" >> _className >> "displayName"): {
        getText(configFile >> "CfgMagazines" >> _className >> "displayName");
    };
    case isText(configFile >> "CfgWeapons" >> _className >> "displayName"): {
        getText(configFile >> "CfgWeapons" >> _className >> "displayName");
    };
    case isText(configFile >> "CfgVehicles" >> _className >> "displayName"): {
        getText(configFile >> "CfgVehicles" >> _className >> "displayName");
    };
    default {
        format["Unknown %1", _className]
    };
};

[_caption, localize _message] call A3A_fnc_customHint;

nil;
