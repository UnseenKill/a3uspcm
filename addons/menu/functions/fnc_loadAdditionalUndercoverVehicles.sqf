#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadAdditionalUndercoverVehicles

Description:
    Loads additional undercover vehicles from the save file.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(loadAdditionalUndercoverVehicles),_this);

if (GVAR(AdditionalUndercoverVehicles) isEqualTo false) then {
    INFO("loading additional vehicles");

    [QGVAR(AdditionalUndercoverVehicles)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalUndercoverVehicles)) || !(GVAR(AdditionalUndercoverVehicles) isEqualType [])) then {
        INFO("No saved additional undercover vehicles found, initializing empty array");
        GVAR(AdditionalUndercoverVehicles) = [];
    } else {
        INFO("Loading additional undercover vehicles from saved data");

        GVAR(AdditionalUndercoverVehicles) apply {
            undercoverVehicles pushBack _x;
        };
    };
};

nil;
