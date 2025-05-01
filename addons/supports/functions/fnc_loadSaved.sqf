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

    [SUPPORT_TYPE_ARTILLERY, SUPPORT_TYPE_CAS_HELICOPTER, SUPPORT_TYPE_CAS_PLANE, SUPPORT_TYPE_TRANSPORT] apply {
        private _present = !isNull(GVAR(supportBuildings) getOrDefault[_x, objNull]);
        INFO_2("* support building for %1 present: %2",_x,_present);
    };

    [QGVAR(supportSpecialists)] call A3A_fnc_getStatVariable;

    if (isNil QGVAR(supportSpecialists)) then {
        INFO("No saved specialists found, defaulting to all available as backwards compatibility");

        GVAR(supportSpecialists) = false;
    } else {
        INFO_1("Loading saved support specialists from %1",GVAR(supportSpecialists));

        if !(GVAR(supportSpecialists) isEqualType []) then {
            WARNING("Invalid specialists data type, initializing with empty array");
            TRACE_1("invalid value",GVAR(supportSpecialists));

            GVAR(supportSpecialists) = false;
        };
    };

    if (GVAR(supportSpecialists) isEqualTo false) then {
        GVAR(supportSpecialists) = [
            [SUPPORT_TYPE_ARTILLERY, SUPPORT_TYPE_CAS_HELICOPTER, SUPPORT_TYPE_CAS_PLANE, SUPPORT_TYPE_TRANSPORT] apply {
                [_x, !isNull(GVAR(supportBuildings) getOrDefault[_x, objNull])]
            }
        ];
    };

    GVAR(supportSpecialists) = createHashMapFromArray GVAR(supportSpecialists);

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
