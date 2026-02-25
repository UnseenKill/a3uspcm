#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_updateGroupVehicles

Description:
    CBA_EVENT_AAFC_VEHICLES_UPDATE event handler

Parameters:
    0: _group - Group to update <GROUP>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(updateGroupVehicles),_this);

#ifdef AAFC_FSM_DEBUG_DURING_DEVELOPMENT
    #define FSM_DEBUG true
#else
    #define FSM_DEBUG false
#endif // AAFC_FSM_DEBUG_DURING_DEVELOPMENT

if !assert(params[
    ["_group", nil, [grpNull]]
]) exitWith {};
if !assert(!isNull _group) exitWith {};

_group getVariable[QGVAR(vehicles), []] select {
    [_x] call FUNC(isRadar);
} apply {
    if (GVAR(radarsExecuteFSM) && {isNil { _x getVariable QGVAR(radarFSM) }}) then {
        _x setVariable[QGVAR(radarFSM), [_x, FSM_DEBUG] execFSM QPATHTOF(aafc-radar-scan.fsm)];
    };

    if (GVAR(radarsUseStrobeLights)) then {
        [CBA_EVENT_AAFC_RADAR_STROBE, [_x]] call CBA_fnc_globalEventJIP;
    };
};

nil;
