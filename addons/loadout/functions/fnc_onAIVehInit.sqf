#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_onAIVehInit

Description:
    AIVehInit event handler for loadouts.

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

_vehicle addAction[
    localize LSTRING(HintLoadoutManageCaption),
    { call FUNC(openLoadoutManagementDialog) },
    [],
    -200,
    false,
    true,
    "",
    QUOTE([ARR_2(_target,player)] call FUNC(canUseLoadoutMenu)),
    5
];

nil;
