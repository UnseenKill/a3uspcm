#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_healGroup

Description:
    Heal all units in current group

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_healGroup;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 healed group",name player);
{ [_x, _x] call ace_medical_treatment_fnc_fullHeal } forEach units group player;

if !isNull(objectParent player) then {
    INFO_1("healing vehicle %1 as well",typeOf objectParent player);
    (objectParent player) setDamage 0;
};

nil;
