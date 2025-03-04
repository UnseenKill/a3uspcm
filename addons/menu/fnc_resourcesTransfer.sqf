#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_resourcesTransfer

Description:
    Transfer money back from FIA with a fee

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(resourcesTransfer),_this);

openMap false;

[localize LSTRING(Resources_TransferPrompt) + ":", "1000", {
    params["_amountStr"];

    private _amount = parseNumber _amountStr;
    private _percentage = GVAR(fiaTransferFee);
    private _fee = _amount * _percentage / 100;
    private _resourcesFIAT = server getVariable "resourcesFIA";

    if (_amount <= 0) exitWith {};

    if ((_amount + _fee) > _resourcesFIAT) exitWith {
        [
            localize LSTRING(Resources_TransferCaption),
            localize LSTRING(Resources_TransferFailedText)
        ] call A3A_fnc_customHint;
        playSound "A3AP_UiFailure";
    };

    TRACE_3(QFUNCMAIN(resourcesTransfer),_amount,_percentage,_fee);

    [_amount, _percentage, _fee] spawn {
        params["_amount", "_percentage", "_fee"];
        uiSleep 1.25;

        private _guiCaption = localize LSTRING(Resources_TransferCaption);
        private _guiMessage = format[localize LSTRING(Resources_TransferConfirmation), _amount, _percentage, "%", _amount + _fee];

        if ([_guiMessage, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
            [0, -1 * (_amount + _fee)] remoteExec ["A3A_fnc_resourcesFIA", 2];
            [_amount] call A3A_fnc_resourcesPlayer;

            playSound "A3AP_UiSuccess";
        };
    };
}] call FUNCMAIN(utilPromptText);

nil;
