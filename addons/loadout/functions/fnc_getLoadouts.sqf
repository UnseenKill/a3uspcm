#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_getLoadouts

Description:
    Retrieve loadouts stored in A3U save game

Parameters:

Optional:

Example:
    (begin example)
    private _loadouts = [] call FUNC(getLoadouts);
    (end)

Returns:
    Loadouts <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if (GVAR(Loadouts) isEqualType false) then {
    INFO("Loadouts not loaded, initializing...");

    [QGVAR(Loadouts)] call A3A_fnc_getStatVariable;

    if isNil QGVAR(Loadouts) then {
        INFO("No saved loadouts found, initializing empty array");
        GVAR(Loadouts) = [];
    } else {
        INFO("Loading saved loadouts");

        if !(GVAR(Loadouts) isEqualType []) then {
            WARNING("Invalid loadouts data type, initializing with empty array");
            TRACE_1("invalid value",GVAR(Loadouts));

            GVAR(Loadouts) = [];
        };

    };

    TRACE_1("loaded",GVAR(Loadouts));
};

GVAR(Loadouts);
