#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_addToBuildableObjects

Description:
    Add a support tent to the buildable objects.

Parameters:
    0: _config - Tent config <CONFIG>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(addToBuildableObjects),_this);

params[
    ["_config",configNull,[configNull]]
];

if !assert(!isNull _config) exitWith {};

private _multiplier = [_config >> "costMultiplier", "NUMBER", 1] call CBA_fnc_getConfigEntry;
private _cost = _multiplier * GVAR(supportBuildingCost);

A3A_buildableObjects pushBack[configName _config, _cost];

INFO_3("Adding %1 to buildable objects with cost %2 and multiplier %3",getText(_config >> "displayName"),_cost,_multiplier);


nil;
