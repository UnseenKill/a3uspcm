#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_unlockBreachingChargeAPCs

Description:
    Unlocks the specified item of equipment for use in the arsenal.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_unlockBreachingChargeAPCs;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
INFO_1("Unlocking APC breaching charges for '%1'",name player);

A3A_faction_reb get "breachingExplosivesAPC" apply {
    [_x select 0] call FUNCMAIN(utilUnlockArsenalItem);
};

nil;
