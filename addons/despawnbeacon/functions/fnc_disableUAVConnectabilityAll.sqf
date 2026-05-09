#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_disableUAVConnectabilityAll

Description:
    Disables UAV connectability for all present DSB UAVs.

Parameters:

Optional:

Example:
    (begin example)
    [] call FUNC(disableUAVConnectabilityAll);
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(disableUAVConnectabilityAll),_this);

GVAR(Entities) apply {
    if (isNull _x) then { continue };

    private _uav = _x getVariable QGVAR(UAV);

    TRACE_2(QFUNC(disableUAVConnectabilityAll),_x,RETNIL(_uav));

    if !(isNil "_uav") then {
        [_uav] call FUNC(disableUAVConnectability);
    };
};

nil;
