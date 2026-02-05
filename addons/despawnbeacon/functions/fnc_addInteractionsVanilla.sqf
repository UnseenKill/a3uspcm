#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_addInteractionsVanilla

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
TRACE_1(QFUNC(addInteractionsVanilla),_this);

params[
    ["_beacon",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith {};

_beacon addAction[
    LLSTRING(ActionActivateText),
    { call FUNC(activateBeacon) },
    [],
    -20,    // priority
    false,  // show in 3D
    true,   // hide on use
    "",     // shortcut
    QUOTE([_target] call FUNC(canActivate)),
    5       // radius
];

_beacon addAction[
    LLSTRING(ActionDeactivateText),
    { call FUNC(deactivateBeacon) },
    [],
    -20,    // priority
    false,  // show in 3D
    true,   // hide on use
    "",     // shortcut
    QUOTE([_target] call FUNC(canDeactivate)),
    5       // radius
];

_beacon addAction[
    LLSTRING(ActionBeaconPackText),
    { call FUNC(packBeacon) },
    [],
    -20,    // priority
    false,  // show in 3D
    true,   // hide on use
    "",     // shortcut
    QUOTE([_target] call FUNC(canPack)),
    5       // radius
];

nil;
