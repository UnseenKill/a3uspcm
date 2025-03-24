#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_unlockPermanentMarker

Description:
    Unlocks the permanent marker item for use in the arsenal.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_unlockPermanentMarker;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
INFO_1("Unlocking permanent marker for '%1'",name player);

[QEGVAR(markers,PermanentMarker)] call FUNCMAIN(utilUnlockArsenalItem);

nil;
