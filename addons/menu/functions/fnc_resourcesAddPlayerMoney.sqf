#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_resourcesAddPlayerMoney

Description:
    Add money to player account

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_resourcesAddPlayerMoney;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
[(LLSTRING(Resources_AddMoneyPrompt)) + ":", "5000", {
    params["_amount"];

    _amount = parseNumber _amount;
    if (_amount isEqualType false || 0 == _amount) exitWith {};

    INFO_2("%1 added %2 to own funds",name player,_amount);
    [_amount] call A3A_fnc_resourcesPlayer;

    [
        LLSTRING(Resources_AddPlayerMoneyCaption),
        format[LLSTRING(Resources_AddPlayerMoneyText), _amount]
    ] call A3A_fnc_customHint;
}] call FUNCMAIN(utilPromptText);

nil;
