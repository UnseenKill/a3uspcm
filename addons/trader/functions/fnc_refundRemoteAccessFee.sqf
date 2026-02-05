#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_refundRemoteAccessFee

Description:
    Refunds remote access fee to player if they paid it.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(refundRemoteAccessFee),_this);

if (player getVariable[QGVAR(feePaid), 0] > 0) then {
    private _amount = player getVariable QGVAR(feePaid);
    player setVariable[QGVAR(feePaid), nil];

    INFO_1("Refund remote access fee to player (%1).",_amount);
    [_amount] call A3A_fnc_resourcesPlayer;

    [
        LLSTRING(HintCaption),
        format[LLSTRING(HintRefundAccessFee), _amount, A3A_faction_civ get "currencySymbol"]
    ] call A3A_fnc_customHint;

    playSound "A3AP_UiFailure";
};

nil;
