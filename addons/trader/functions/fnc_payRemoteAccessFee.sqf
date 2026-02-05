#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_payRemoteAccessFee

Description:
    Deducts remote access fee from player money.

Parameters:

Optional:

Returns:
    <BOOL> Whether the player could pay the remote access fee.

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(payRemoteAccessFee),_this);

player setVariable[QGVAR(feePaid), nil];

if (GVAR(remoteTraderFee) <= 0) exitWith {
    INFO("Remote trader access fee is zero or less; no payment required.");
    true;
};

if (player getVariable "moneyX" < GVAR(remoteTraderFee)) exitWith {
    INFO("Player does not have enough money to pay remote access fee.");
    
    [
        LLSTRING(HintCaption),
        format[LLSTRING(HintNotEnoughMoneyForFee), GVAR(remoteTraderFee), A3A_faction_civ get "currencySymbol"]
    ] call A3A_fnc_customHint;

    playSound "A3AP_UiFailure";
    false;
};

if (GVAR(showAccessFeeHint) &&
    { !([format[LLSTRING(HintConfirmAccessFee), GVAR(remoteTraderFee), A3A_faction_civ get "currencySymbol"], LLSTRING(HintCaption), true, true] call BIS_fnc_guiMessage) }) exitWith {
    INFO("No player consent to remote access fee.");
    false;
};

[-GVAR(remoteTraderFee)] call A3A_fnc_resourcesPlayer;
player setVariable[QGVAR(feePaid), GVAR(remoteTraderFee)];

true;
