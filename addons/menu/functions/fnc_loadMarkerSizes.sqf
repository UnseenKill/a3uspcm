#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadMarkerSizes

Description:
    Restore changed markers

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(loadMarkerSizes),_this);

if (GVAR(MarkerSizes) isEqualTo false) then {
    INFO("loading changed markers");

    [QGVAR(MarkerSizes)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(MarkerSizes)) || !(GVAR(MarkerSizes) isEqualType [])) then {
        INFO("No saved markers found, initializing empty array");
        GVAR(MarkerSizes) = createHashMap;
    } else {
        INFO("Loading changed markers from saved data");

        GVAR(MarkerSizes) = createHashMapFromArray GVAR(MarkerSizes);
        GVAR(MarkerSizes) apply {
            TRACE_2(QFUNC(loadMarkerSizes),_x,_y);
            _x setMarkerSize[_y, _y];
        };
    };
};

nil;
