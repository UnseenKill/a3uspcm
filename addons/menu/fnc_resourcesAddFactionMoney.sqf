#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_resourcesAddFactionMoney

Description:
    Add money to faction account

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_resourcesAddFactionMoney;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
[(localize LSTRING(Resources_AddMoneyPrompt)) + ":", "5000", {
    params["_amount"];

    _amount = parseNumber _amount;
    if (_amount isEqualType false || 0 == _amount) exitWith {};

    INFO_2("%1 added %2 to faction money",name player,_amount);
    [0,_amount] remoteExec ["A3A_fnc_resourcesFIA",2];

    [
        localize LSTRING(Resources_AddFactionMoneyCaption),
        format[localize LSTRING(Resources_AddFactionMoneyText), _amount]
    ] call A3A_fnc_customHint;
}] call FUNCMAIN(utilPromptText);

nil;
