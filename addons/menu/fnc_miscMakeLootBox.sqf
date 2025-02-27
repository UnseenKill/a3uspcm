#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscMakeLootBox

Description:
    Turn cursor target into lootbox to collect scattered loot.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscMakeLootBox;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if visibleMap then {
    openMap false;
};

[] spawn {
    uiSleep 2.5;

    [cursorTarget] spawn {
        params[["_target", objNull, [objNull]]];

        if ((isNull _target) && (player getVariable["moneyX", 0] < GVAR(lootboxCost))) exitWith {
            [
                localize LSTRING(Miscellaneous_MakeLootBoxCaption),
                format[localize LSTRING(Miscellaneous_MakeLootBoxHintNoMoneyText), GVAR(lootboxCost)]
            ] call A3A_fnc_customHint;
        };

        if (isNull _target) then {
            private _vector = player weaponDirection currentWeapon player;
            private _beg = ASLToAGL eyePos player;
            private _pos = _beg vectorAdd (_vector vectorMultiply 2);
            _target = createVehicle[A3A_faction_reb get "lootCrate", _pos, [], 0, "NONE"];

            if (GVAR(lootboxCost) > 0) then {
                [-GVAR(lootboxCost)] call A3A_fnc_resourcesPlayer;
            };

            [_target] call A3A_Logistics_fnc_addLoadAction;
            [_target] call A3A_fnc_initMovableObject;

            clearMagazineCargoGlobal _target;
            clearWeaponCargoGlobal _target;
            clearItemCargoGlobal _target;
            clearBackpackCargoGlobal _target;
        };

        INFO_2("player %1 wants %2 turned into lootbox",name player,typeOf _target);

        [_target] remoteExec["SCRT_fnc_loot_addActionLoot", 2];
        
        [
            localize LSTRING(Miscellaneous_MakeLootBoxCaption),
            format[localize LSTRING(Miscellaneous_MakeLootBoxHintSuccessText), getText(configOf _target >> "displayName")]
        ] call A3A_fnc_customHint;
    };
};

nil;
