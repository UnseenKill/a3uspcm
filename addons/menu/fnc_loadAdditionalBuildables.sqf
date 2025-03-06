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
TRACE_1(QFUNC(loadAdditionalBuildables),_this);

if (GVAR(AdditionalBuildables) isEqualTo false) then {
    INFO("loading additional buildable objects");

    if GVAR(additionalBuildablesStartEmpty) exitWith {
        INFO("not loading additional buildable objects, as instructed by setting");
        
        GVAR(AdditionalBuildables) = [];
        [QGVAR(AdditionalBuildables), GVAR(AdditionalBuildables)] call A3A_fnc_setStatVariable;
    };

    [QGVAR(AdditionalBuildables)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalBuildables)) || !(GVAR(AdditionalBuildables) isEqualType [])) then {
        INFO("No saved additional buildables found, initializing empty array");
        GVAR(AdditionalBuildables) = [];
        [QGVAR(AdditionalBuildables), GVAR(AdditionalBuildables)] call A3A_fnc_setStatVariable;
    } else {
        INFO("Loading additional buildables from saved data");
        GVAR(AdditionalBuildables) apply {
            TRACE_1(QFUNC(loadAdditionalBuildables),_x);
            A3A_buildableObjects pushBack _x;
        };
    };
};

nil;
