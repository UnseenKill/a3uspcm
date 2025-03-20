#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_unlockAceEHP

Description:
    Unlocks the ACE EHP item for use in the arsenal.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_unlockAceEHP;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
INFO_1("Unlocking ACE EHP for '%1'",name player);

["ACE_EHP"] call FUNCMAIN(utilUnlockArsenalItem);

nil;
