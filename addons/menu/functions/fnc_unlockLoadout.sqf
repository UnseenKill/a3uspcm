#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_unlockLoadout

Description:
    Unlock everything from player's current loadout

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_unlockLoadout;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
INFO_1("'%1' is unlocking everything in their current loadout",name player);

[getUnitLoadout player] call FUNCMAIN(utilUnlockLoadout);

nil;
