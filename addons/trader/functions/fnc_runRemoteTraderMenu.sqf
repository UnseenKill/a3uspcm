#include "..\script_component.hpp"
#include "\x\A3A\addons\hals\Addons\store\dialog\idcs.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_runRemoteTraderMenu

Description:
    Runs the remote trader menu.

Parameters:
    0: _object - Remote trading terminal object <OBJECT>
    1: _player - Player using the remote trader menu <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(runRemoteTraderMenu),_this);

if !assert(params[
    ["_object", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};
if !assert(!isNull _player) exitWith {};

if !assert(!isNil "traderX") exitWith {};

[] spawn {
    if (!isNil QGVAR(airdropContainer)) exitWith {
        WARNING("A remote trader airdrop is already active; cannot open another remote trader menu.");

        [LLSTRING(HintCaption), LLSTRING(HintAirdropUnderway) ] call A3A_fnc_customHint;
        playSound "A3AP_UiFailure";
    };

    if (missionNamespace getVariable[QGVAR(airDropCooldownTime), 0] > time) exitWith {
        WARNING("Remote trader is on cooldown; cannot open remote trader menu.");

        [
            LLSTRING(HintCaption),
            format[LLSTRING(HintAirdropOnCooldown), [(missionNamespace getVariable[QGVAR(airDropCooldownTime), 0]) - time, "MM:SS"] call BIS_fnc_secondsToString]
        ] call A3A_fnc_customHint;
        playSound "A3AP_UiFailure";
    };

    if !([] call FUNC(payRemoteAccessFee)) exitWith {
        WARNING("Player could not pay remote access fee; aborting remote trader menu.");
    };

    private _position = getPosATL traderX findEmptyPosition[10, 20, QEGVAR(assets,RemoteTraderAirdropContainer)];
    if (_position isEqualTo []) then {
        WARNING("Could not find suitable position for remote trader airdrop container.");
        _position = getPosATL traderX vectorAdd[20, 0, 0];
    };

    GVAR(airdropContainer) = [_position] call FUNC(createAirdropContainer);

    [traderX] call HALs_store_fnc_openStore;
    
    waitUntil { !isNull findDisplay IDD_DISPLAY_STORE };
    uiSleep 0.5;
    [] call FUNC(modifyRscDisplayStore);

    waitUntil { isNull findDisplay IDD_DISPLAY_STORE };

    if (loadAbs GVAR(airdropContainer) isEqualTo 0) exitWith {
        INFO("Remote trader airdrop container empty; deleting.");
        [] call FUNC(refundRemoteAccessFee);
        deleteVehicle GVAR(airdropContainer);
        GVAR(airdropContainer) = nil;
    };

    [GVAR(airdropContainer), getPosATL player] spawn FUNC(deliverAirdrop);
};

nil;
