#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_loadSaved

Description:
    Load saved data

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(loadSaved),_this);

if (GVAR(supportSpecialists) isEqualTo false) then {
    INFO("Support specialists not loaded, initializing...");

    [QGVAR(supportSpecialists)] call A3A_fnc_getStatVariable;

    if (isNil QGVAR(supportSpecialists)) then {
        INFO("No saved specialists found, defaulting to all available as backwards compatibility");

        GVAR(supportSpecialists) = [
            [SUPPORT_TYPE_ARTILLERY, true],
            [SUPPORT_TYPE_CAS_HELICOPTER, true],
            [SUPPORT_TYPE_CAS_PLANE, true],
            [SUPPORT_TYPE_TRANSPORT, true]
        ];
    } else {
        INFO("Loading saved support specialists");

        if !(GVAR(supportSpecialists) isEqualType []) then {
            WARNING("Invalid markers data type, initializing with empty array");
            TRACE_1("invalid value",GVAR(supportSpecialists));

            GVAR(supportSpecialists) = [];
        };
    };

    GVAR(supportSpecialists) = createHashMapFromArray GVAR(supportSpecialists);
    [QGVAR(supportSpecialists), GVAR(supportSpecialists)] call A3A_fnc_setStatVariable;

    [
        {
            INFO("support specialists loaded, setting up tents");
            GVAR(supportBuildings) apply {
                [_y] call FUNC(setupSupportTent);
            };
        }
    ] call CBA_fnc_execNextFrame;
};

nil;
