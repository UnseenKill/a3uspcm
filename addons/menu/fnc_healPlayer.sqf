#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_healPlayer

Description:
    Heal current player

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_healPlayer;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 healed self",name player);
[player, player] call ace_medical_treatment_fnc_fullHeal;

nil;
