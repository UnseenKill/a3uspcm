#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_unlockAcePainkillers

Description:
    Unlocks the ACE Painkillers item for use in the arsenal.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_unlockAcePainkillers;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
INFO_1("Unlocking ACE Painkillers for '%1'",name player);

["ACE_painkillers"] call FUNCMAIN(utilUnlockArsenalItem);

nil;
