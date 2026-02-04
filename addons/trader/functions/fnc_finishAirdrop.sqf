#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_finishAirdrop

Description:
    Finalizes the airdrop process by unlocking the inventory of the airdrop container.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled, ...

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(finishAirdrop),_this);

if !assert(!isNil QGVAR(airdropContainer)) exitWith {};

GVAR(airdropContainer) lockInventory false;
GVAR(airdropContainer) = nil;

GVAR(airDropCooldownTime) = time + GVAR(airDropCooldown);

nil;
