#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscUncompromise

Description:
    Allow player and vehicle to go undercover again.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscUncompromise;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
INFO_1("player %1 wants to go undercover again",name player);

if !(isNull objectParent player) then {
    TRACE_1("unreporting car",objectParent player);
    objectParent player setVariable["A3A_reported", nil, true];
};

units group player apply { 
    TRACE_1("uncompromizing",_x);
    _x setVariable["compromised", 0, true]; 
};

[
    localize LSTRING(Miscellaneous_UncompromiseCaption),
    localize LSTRING(Miscellaneous_UncompromiseSuccess)
] call A3A_fnc_customHint;

nil;
