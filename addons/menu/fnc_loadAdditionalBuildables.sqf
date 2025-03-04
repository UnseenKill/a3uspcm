#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadAdditionalBuildables

Description:
    Load additional buildable objects

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if (GVAR(AdditionalBuildables) isEqualTo false) then {
    INFO("loading additional buildable objects");

    [QGVAR(AdditionalBuildables)] call A3A_fnc_getStatVariable;
    
    if (isNil QGVAR(AdditionalBuildables)) then {
        INFO("No saved additional buildables found, initializing empty array");
        GVAR(AdditionalBuildables) = [];
        [QGVAR(AdditionalBuildables), GVAR(AdditionalBuildables)] call A3A_fnc_setStatVariable;
    } else {
        INFO("Loading additional buildables from saved data");
        GVAR(AdditionalBuildables) apply {
            TRACE_1(QFUNC(loadAdditionalBuildables),_x);
            A3A_buildableObjects append _x;
        };
    };
};

nil;
