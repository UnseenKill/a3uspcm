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

[
    _vehicle,
    localize LSTRING(HintLoadoutManageCaption),
    "a3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    "a3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    QUOTE([ARR_2(_target,player)] call FUNC(canUseLoadoutMenu)),
    "true",
    {},
    {},
    { call FUNC(openLoadoutManagementDialog) },
    {},
    [],
    3,
    -200
] call BIS_fnc_holdActionAdd;

nil;
