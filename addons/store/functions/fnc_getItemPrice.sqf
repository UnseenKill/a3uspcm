#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_store_fnc_getItemPrice

Description:
    Get price of item from HALs store addon

Parameters:
    0: _class - class name of item <STRING>

Optional:

Example:
    (begin example)
    ["16Rnd_9x21_Mag"] call A3USPCM_store_fnc_getItemPrice;
    (end example)

Returns:
    Price <NUMBER> or <BOOL> false if not found

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_class", "", [""]]
];

private _price = false;

private _index = _className call jn_fnc_arsenal_itemType;
private _arsenal = jna_datalist select _index;
private _count = [_arsenal, _className] call jn_fnc_arsenal_itemCount;

if (_count < 0) exitWith { false };

("true" configClasses(configFile >> "CfgHALsAddons" >> "cfgHALsStore" >> "categories")) findIf {
    //diag_log format["%1: %2 => %3", _class, _x, isClass(_x >> _class)];

    if !isClass(_x >> _class) then {
        false;
    } else {
        _price = getNumber(_x >> _class >> "price");
        true;
    };
};

_price;
