#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_addInteractionsACE

Description:
    Add interactions to the despawn beacon.

Parameters:
    0: _beacon - Beacon <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(addInteractionsACE),_this);

params[
    ["_beacon",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith {};

[
    _beacon, 0, ["ACE_MainActions"],
    [
        "ace_attach_AttachVehicle",
        localize "$STR_ace_attach_AttachDetach",
        QUOTE(\z\ace\addons\attach\UI\attach_ca.paa),
        {},
        { call ace_attach_fnc_canAttach },
        { call ace_attach_fnc_getChildrenActions }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[
    _beacon, 0, ["ACE_MainActions"],
    [
        "ace_attach_DetachVehicle",
        localize "$STR_ace_attach_Detach",
        QUOTE(\z\ace\addons\attach\UI\detach_ca.paa),
        { call ace_attach_fnc_detach },
        { call ace_attach_fnc_canDetach }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[
    _beacon, 0, ["ACE_MainActions"],
    [
        QGVAR(ActionBeaconActivate),
        LLSTRING(ActionActivateText),
        "",
        { call FUNC(activateBeacon) },
        { call FUNC(canActivate) }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[
    _beacon, 0, ["ACE_MainActions"],
    [
        QGVAR(ActionBeaconDeactivate),
        LLSTRING(ActionDeactivateText),
        "",
        { call FUNC(deactivateBeacon) },
        { call FUNC(canDeactivate) }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[
    _beacon, 0, ["ACE_MainActions"],
    [
        QGVAR(ActionBeaconPack),
        LLSTRING(ActionBeaconPackText),
        "",
        { call FUNC(packBeacon) },
        { call FUNC(canPack) }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

nil;
