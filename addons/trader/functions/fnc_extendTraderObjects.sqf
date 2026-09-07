#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_extendTraderObjects

Description:
    Add supply box to trader objects

Parameters:

Optional:

Example:

Returns:
    Nothing

Environment:
    Server, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(extendTraderObjects),_this);

INFO("Waiting for 'SCRT_fnc_trader_createTrader' to become available...");
waitUntil { !isNil "SCRT_fnc_trader_createTrader" };
INFO("'SCRT_fnc_trader_createTrader' is now available; hooking.");

GVAR(SCRT_fnc_trader_createTrader) = SCRT_fnc_trader_createTrader;
SCRT_fnc_trader_createTrader = {
    params["_position"];
    TRACE_1("SCRT_fnc_trader_createTrader",_this);
    private _result = call GVAR(SCRT_fnc_trader_createTrader);
    private _boxPos = _position vectorAdd[-2.271, 6.18359, 0];
    private _supplyBox = "B_CargoNet_01_ammo_F" createVehicle[0, 0, 0];
    _supplyBox enableSimulationGlobal false;
    _supplyBox setVectorUp surfaceNormal _boxPos;
    _supplyBox setPosATL _boxPos;

    clearBackpackCargoGlobal _supplyBox;
    clearItemCargoGlobal _supplyBox;
    clearMagazineCargoGlobal _supplyBox;
    clearWeaponCargoGlobal _supplyBox;

    traderObjects pushBack _supplyBox;

    _result;
};

nil;
