#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_handlerBeaconPostInit

Description:
    Post init function for despawn beacon.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerBeaconPostInit),_this);

params[
    ["_beacon",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith {};

GVAR(Entities) pushBackUnique _beacon;

[
    _beacon, 0, ["ACE_MainActions"],
    [
        QGVAR(ActionBeaconActivate),
        localize LSTRING(ActionActivateText),
        "",
        { call FUNC(activateBeacon) },
        { call FUNC(canActivate) }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[
    _beacon, 0, ["ACE_MainActions"],
    [
        QGVAR(ActionBeaconDeactivate),
        localize LSTRING(ActionDeactivateText),
        "",
        { call FUNC(deactivateBeacon) },
        { call FUNC(canDeactivate) }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

nil;
