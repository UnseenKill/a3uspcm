#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_createAirdropContainer

Description:
    Creates airdrop container for remote trader.

Parameters:
    0: _position - Position where the airdrop container will be created <ARRAY>

Optional:

Returns:
    <OBJECT> Created airdrop container

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(createAirdropContainer),_this);

if !assert(params[
    ["_position", nil, [[]], 3]
]) exitWith {};

private _airdropContainer = QEGVAR(assets,RemoteTraderAirdropContainer) createVehicle[0,0,0];
_airdropContainer setPosATL _position;
_airdropContainer lockInventory true;

#ifndef __A3USPCM_PRODUCTION__
    allCurators apply { _x addCuratorEditableObjects[[_airdropContainer], false] };
#endif // __A3USPCM_PRODUCTION__

_airdropContainer;
