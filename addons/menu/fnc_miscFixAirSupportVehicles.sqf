#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscFixAirSupportVehicles

Description:
    Remove clunky old planes from air support, add jet.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscFixAirSupportVehicles;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 wants air support fixed",name player);
A3A_faction_reb set["vehiclesPlane",["B_Plane_Fighter_01_Stealth_F"]];

nil;
