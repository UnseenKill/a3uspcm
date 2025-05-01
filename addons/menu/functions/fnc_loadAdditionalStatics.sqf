#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadAdditionalStatics

Description:
    Load additional buyable static emplacements

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(loadAdditionalStatics),_this);

if (GVAR(AdditionalStatics) isEqualTo false) then {
    INFO("loading additional buildable objects");

    [QGVAR(AdditionalStatics)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalStatics)) || !(GVAR(AdditionalStatics) isEqualType [])) then {
        INFO("No saved additional statics found, initializing empty array");
        GVAR(AdditionalStatics) = [];
    } else {
        INFO("Loading additional statics from saved data");
        GVAR(AdditionalStatics) apply {
            TRACE_1(QFUNC(loadAdditionalStatics),_x);

            A3A_faction_reb get "staticMGs" pushBackUnique (_x select 0);
            A3U_blackMarketStock pushBack [
                _x select 0, // classname
                _x select 1, // price
                "STATICMG", // type
                {true} // condition
            ];
        };
    };
};

nil;
