#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_resourcesAddHR

Description:
    Add faction HR

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_resourcesAddHR;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
[(localize LSTRING(Resources_AddHRPrompt)) + ":", "8", {
    params["_amount"];

    _amount = parseNumber _amount;
    if (_amount isEqualType false || 0 == _amount) exitWith {};

    INFO_2("%1 added %2 to faction HR",name player,_amount);
    [_amount,0] remoteExec ["A3A_fnc_resourcesFIA",2];

    [
        localize LSTRING(Resources_AddHRCaption),
        format[localize LSTRING(Resources_AddHRText), _amount]
    ] call A3A_fnc_customHint;
}] call FUNCMAIN(utilPromptText);

nil;
