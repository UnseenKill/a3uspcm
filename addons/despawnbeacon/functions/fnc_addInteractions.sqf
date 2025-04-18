#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_addInteractions

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
TRACE_1(QFUNC(addInteractions),_this);

params[
    ["_beacon",objNull,[objNull]]
];

if !assert(!isNull _beacon) exitWith {};
if EGVAR(main,AceHaveAddon) then {
    [_beacon] call FUNC(addInteractionsACE);
} else {
    [_beacon] call FUNC(addInteractionsVanilla);
};

nil;
