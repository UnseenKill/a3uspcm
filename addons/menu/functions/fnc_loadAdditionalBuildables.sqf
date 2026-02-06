#include "..\script_component.hpp"
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

if isNil(QGVAR(AdditionalBuildables)) then {
    INFO("loading additional buildable objects");

    if GVAR(additionalBuildablesStartEmpty) exitWith {
        INFO("not loading additional buildable objects, as instructed by setting");
        
        GVAR(AdditionalBuildables) = [];
    };

    [QGVAR(AdditionalBuildables)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalBuildables)) || { !(GVAR(AdditionalBuildables) isEqualType []) }) then {
        INFO("No saved additional buildables found, initializing empty array");
        GVAR(AdditionalBuildables) = [];
    } else {
        INFO("Loading additional buildables from saved data");
    };
};

publicVariable QGVAR(AdditionalBuildables);

nil;
