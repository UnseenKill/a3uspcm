#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_unlockSortArsenal

Description:
    SORT THAT FRIGGIN MESS OF AN ARSENAL

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(unlockSortArsenal),_this);

if !(isServer) exitWith {
    _this remoteExecCall[QFUNC(unlockSortArsenal), 2];
};

jna_datalist = jna_datalist apply {
    private _list = _x apply {
        [
           switch true do {
                case isText(configFile >> "CfgMagazines" >> (_x # 0) >> "displayName"): {
                    getText(configFile >> "CfgMagazines" >> (_x # 0) >> "displayName");
                };
                case isText(configFile >> "CfgWeapons" >> (_x # 0) >> "displayName"): {
                    getText(configFile >> "CfgWeapons" >> (_x # 0) >> "displayName");
                };
                case isText(configFile >> "CfgVehicles" >> (_x # 0) >> "displayName"): {
                    getText(configFile >> "CfgVehicles" >> (_x # 0) >> "displayName");
                };
                default { _x # 0 };
            },
            _x # 0,
            _x # 1
        ]
    };

    _list sort true;
    _list apply {
        [_x # 1, _x # 2]
    };
};

if (isRemoteExecuted) exitWith {
    [LLSTRING(Unlocks_SortArsenalCaption), LLSTRING(Unlocks_SortArsenalTextSuccess)] remoteExecCall["A3A_fnc_customHint", remoteExecutedOwner];
    "A3AP_UiSuccess" remoteExecCall["playSound", remoteExecutedOwner];
};

[
    LLSTRING(Unlocks_SortArsenalCaption),
    LLSTRING(Unlocks_SortArsenalTextSuccess)
] call A3A_fnc_customHint;

playSound "A3AP_UiSuccess";

nil;
