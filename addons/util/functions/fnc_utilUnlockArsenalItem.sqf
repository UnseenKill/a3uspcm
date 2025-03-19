#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilUnlockArsenalItem

Description:
    Unlocks the specified item of equipment for use in the arsenal.

Parameters:
    0: _className - Item class to unlock <STRING>

Optional:
    1: _silent - Suppress hint message for already unlocked items <BOOL>
    2: _unlock - Unlock (TRUE) or discard (FALSE) items <BOOL>

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
    ["_className", "", [""]],
    ["_silent", false, [false]],
    ["_unlock", true, [false]]
];

TRACE_2(QFUNCMAIN(utilUnlockArsenalItem),_unlock,_className);

private _index = _className call jn_fnc_arsenal_itemType;
private _arsenal = jna_datalist select _index;
private _count = [_arsenal, _className] call jn_fnc_arsenal_itemCount;

private _message = if (_count < 0) then {
    if _unlock then {
        [LSTRING(ArsenalItemNotUnlocked), ""] select _silent;
    } else {
        TRACE_1("arsenal",_arsenal);
        _arsenal = _arsenal select { _x isNotEqualTo[_className, -1] };
        jna_datalist set[_index, _arsenal];
        LSTRING(ArsenalItemDiscarded);
    };
} else {
    if !_unlock then {
        [LSTRING(ArsenalItemNotDiscarded), ""] select _silent;
    } else {
        private _result = [_className] call A3A_fnc_unlockEquipment;
        TRACE_1(QFUNCMAIN(utilUnlockArsenalItem),_result);
        LSTRING(ArsenalItemUnlocked);
    };
};

if (_message isNotEqualTo "") then {
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
};

nil;
