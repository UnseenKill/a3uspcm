#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscSpawnLootBox

Description:
    Spawn a lootbox at the player location.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(miscSpawnLootBox),_this);

if ((player getVariable["moneyX", 0] < GVAR(lootboxCost))) exitWith {
    [
        localize LSTRING(Miscellaneous_MakeLootBoxCaption),
        format[localize LSTRING(Miscellaneous_MakeLootBoxHintNoMoneyText), GVAR(lootboxCost)]
    ] call A3A_fnc_customHint;
    playSound "A3AP_UiFailure";
};

private _vector = player weaponDirection currentWeapon player;
private _beg = ASLToAGL eyePos player;
private _pos = _beg vectorAdd (_vector vectorMultiply 2);
private _target = createVehicle[A3A_faction_reb get "lootCrate", _pos, [], 0, "NONE"];

if (GVAR(lootboxCost) > 0) then {
    [-GVAR(lootboxCost)] call A3A_fnc_resourcesPlayer;
};

[_target] call A3A_Logistics_fnc_addLoadAction;
[_target] call A3A_fnc_initMovableObject;
[_target] remoteExec["SCRT_fnc_loot_addActionLoot", 2];

clearMagazineCargoGlobal _target;
clearWeaponCargoGlobal _target;
clearItemCargoGlobal _target;
clearBackpackCargoGlobal _target;

nil;
