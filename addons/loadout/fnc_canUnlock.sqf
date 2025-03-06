#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_canUnlock

Description:
    Callback condition if container's contents can be unlocked for arsenal

Parameters:
    0: _container - Container object <OBJECT>

Optional:

Example:
    (begin example)
    [box1] call A3USPCM_loadout_fnc_canUnlock;
    (end example)

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_container", objNull, [objNull]]
];

if !assert(!isNull _container) exitWith { false };

([_container] call FUNCMAIN(utilVehicleHasCargo))
&&
(!isNil "boxX")
&&
(_container distance2D boxX < ARSENAL_INTERACTION_RADIUS);
