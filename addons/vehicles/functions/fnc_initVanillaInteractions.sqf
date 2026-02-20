#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_initVanillaInteractions

Description:
    Initialize scroll-wheel menu interactions

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initVanillaInteractions),_this);

if (EGVAR(main,AceHaveAddon)) then {
    ["Air", "init", { call FUNC(resupplyInitInteractions) }] call CBA_fnc_addClassEventHandler;
};

["LandVehicle", "init", { call FUNC(meepMeepInitInteractions) }] call CBA_fnc_addClassEventHandler;

nil;
