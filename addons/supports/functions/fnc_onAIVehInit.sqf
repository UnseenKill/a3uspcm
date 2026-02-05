#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onAIVehInit

Description:
    AIVehInit event handler for supports.

Parameters:
    0: _vehicle - Vehile <OBJECT>
    1: _side - Side of vehicle <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onAIVehInit),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_side", sideUnknown, [sideUnknown]]
];

if !assert(!isNull _vehicle) exitWith {};

#define ASSIGN_ACTION(ROLE) {\
    params[["_target", objNull, [objNull]], ["_player", objNull, [objNull]]];\
    [_target, _player, ROLE] call FUNC(assignSupportRoleToVehicle);\
}

_vehicle addAction[
    format[LLSTRING(MenuSupportsVanillaAssignAs), LLSTRING(MenuSupportsAssignAsArtillery)],
    ASSIGN_ACTION(SUPPORT_TYPE_ARTILLERY),
    [],
    -200,
    false,
    true,
    "",
    QUOTE([ARR_3(_target,_this,QUOTE(SUPPORT_TYPE_ARTILLERY))] call FUNC(canAssignSupport)),
    8
];

_vehicle addAction[
    format[LLSTRING(MenuSupportsVanillaAssignAs), LLSTRING(MenuSupportsAssignAsCASPlane)],
    ASSIGN_ACTION(SUPPORT_TYPE_CAS_PLANE),
    [],
    -200,
    false,
    true,
    "",
    QUOTE([ARR_3(_target,_this,QUOTE(SUPPORT_TYPE_CAS_PLANE))] call FUNC(canAssignSupport)),
    8
];

_vehicle addAction[
    format[LLSTRING(MenuSupportsVanillaAssignAs), LLSTRING(MenuSupportsAssignAsCASHelicopter)],
    ASSIGN_ACTION(SUPPORT_TYPE_CAS_HELICOPTER),
    [],
    -200,
    false,
    true,
    "",
    QUOTE([ARR_3(_target,_this,QUOTE(SUPPORT_TYPE_CAS_HELICOPTER))] call FUNC(canAssignSupport)),
    8
];

_vehicle addAction[
    format[LLSTRING(MenuSupportsVanillaAssignAs), LLSTRING(MenuSupportsAssignAsTransport)],
    ASSIGN_ACTION(SUPPORT_TYPE_TRANSPORT),
    [],
    -200,
    false,
    true,
    "",
    QUOTE([ARR_3(_target,_this,QUOTE(SUPPORT_TYPE_TRANSPORT))] call FUNC(canAssignSupport)),
    8
];

_vehicle addAction[
    LLSTRING(MenuSupportsRevokeRole),
    { call FUNC(revokeSupportRoleFromVehicle) },
    [],
    -200,
    false,
    true,
    "",
    QUOTE([_target] call FUNC(canRevokeSupport)),
    8
];

nil;
