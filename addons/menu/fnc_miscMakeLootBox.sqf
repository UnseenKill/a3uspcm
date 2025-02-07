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

[cursorTarget] spawn {
    params[["_target", objNull, [objNull]]];
    uiSleep 1.25;

    if (isNull _target) exitWith {
        [
            localize LSTRING(Miscellaneous_MakeLootBoxCaption),
            localize LSTRING(Miscellaneous_MakeLootBoxHintNoTargetText)
        ] call A3A_fnc_customHint;
    };

    INFO_2("player %1 wants %2 turned into lootbox",name player,typeOf _target);

    [_target] remoteExec["SCRT_fnc_loot_addActionLoot", 2];
    
    [
        localize LSTRING(Miscellaneous_MakeLootBoxCaption),
        format[localize LSTRING(Miscellaneous_MakeLootBoxHintSuccessText), getText(configOf _target >> "displayName")]
    ] call A3A_fnc_customHint;
};

nil;
