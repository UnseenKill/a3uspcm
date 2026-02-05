#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_resourcesShowAll

Description:
    See resources of all factions

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_resourcesShowAll;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
[
    LLSTRING(Resources_ShowResourcesAllCaption),
    format[LLSTRING(Resources_ShowAllText),
        A3A_resourcesDefenceOcc,
        A3A_resourcesAttackOcc,
        A3A_resourcesDefenceInv,
        A3A_resourcesAttackInv
    ]
] call A3A_fnc_customHint;

nil;
