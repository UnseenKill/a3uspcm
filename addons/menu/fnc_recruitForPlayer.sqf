#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_recruitForPlayer

Description:
    Recruit a unit to player squad.

Parameters:
    0: _typeUnit - Type of unit to recruit <STRING>

Optional:

Example:
    (begin example)
    ["unitMG"] call A3USPCM_fnc_recruitForPlayer;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_typeUnit", "", [""]]
];

INFO_2("player %1 wants %2 recruited",name player,_typeUnit);

[A3A_faction_reb get _typeUnit] spawn A3A_fnc_reinfPlayer;

nil;
