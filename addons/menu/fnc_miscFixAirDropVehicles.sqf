#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscFixAirDropVehicles

Description:
    Remove all helicopters from air support, add MH-6.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscFixAirDropVehicles;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 wants air drop fixed",name player);
A3A_faction_reb set["vehiclesCivHeli",["B_Heli_Light_01_F"]];

nil;
