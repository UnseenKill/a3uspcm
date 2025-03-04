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
TRACE_1(QFUNCMAIN(miscMakeLootBox),_this);

[
    {
        params[["_target", objNull, [objNull]]];

        INFO_2("player %1 wants %2 turned into lootbox",name player,typeOf _target);

        if (0 == getNumber(configOf _target >> "maximumLoad")) exitWith {
            [
                localize LSTRING(Miscellaneous_MakeLootBoxCaption),
                format[localize LSTRING(Miscellaneous_MakeLootBoxHintNoCargoSpaceText), getText(configOf _target >> "displayName")]
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };

        [_target] remoteExec["SCRT_fnc_loot_addActionLoot", 2];
        
        [
            localize LSTRING(Miscellaneous_MakeLootBoxCaption),
            format[localize LSTRING(Miscellaneous_MakeLootBoxHintSuccessText), getText(configOf _target >> "displayName")]
        ] call A3A_fnc_customHint;
        playSound "A3AP_UiSuccess";
    },
    [],
    {
        call FUNCMAIN(miscSpawnLootBox);
    }
] call FUNCMAIN(utilCursorTargetAction);

nil;
