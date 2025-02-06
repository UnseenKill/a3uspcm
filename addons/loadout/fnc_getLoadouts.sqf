#include "script_component.hpp"
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

    private _saved = [QGVAR(Loadouts)] call A3A_fnc_getStatVariable;

    if isNil "_saved" then {
        INFO("No saved loadouts found, initializing empty array");
        GVAR(Loadouts) = [];
    } else {
        INFO("Loading saved loadouts");

        if !(_saved isEqualType []) then {
            WARNING("Invalid loadouts data type, initializing with empty array");
            TRACE_1("invalid value",_saved);

            _saved = [];
        };

        GVAR(Loadouts) = _saved;
    };

    TRACE_1("loaded",_saved);

    [QGVAR(Loadouts), GVAR(Loadouts)] call A3A_fnc_setStatVariable;
};

GVAR(Loadouts);
