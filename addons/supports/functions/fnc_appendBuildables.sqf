#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_appendBuildables

Description:
    Add support tents to buildable objects.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(appendBuildables),_this);

if !GVAR(requireSupportBuildings) exitWith {
    INFO("Support buildings are disabled, skipping buildables append.");
};

QUOTE(configName _x find QQGVAR(SupportTent) isNotEqualTo -1) configClasses (configFile >> "CfgVehicles") apply {
    if (getNumber(_x >> "scope") > 0) then {
        private _class = configName _x;

        if !isNull(GVAR(supportBuildings) getOrDefault[_class, objNull]) then {
            INFO_1("NOT adding %1 to buildable objects; an instance exists",getText(_x >> "displayName"));
        } else {
            [_x] call FUNC(addToBuildableObjects);
        };
    };
};

nil;
