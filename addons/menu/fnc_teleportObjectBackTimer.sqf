#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_teleportObjectBackTimer

Description:
    Spawned callback for teleporting object back to origin

Parameters:
    0: _object - The rebel object to teleport back <OBJECT>

Optional:

Example:
    (begin example)
    [boxX] call A3USPCM_menu_fnc_teleportObjectBackTimer;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_object", objNull, [objNull]]
];

if !assert(!isNull _object) exitWith {};

// Wait until relevant object variables are populated
uiSleep 5;

while { alive player } do {
    uiSleep 1;

    if (_object getVariable[QGVAR(teleportOrigin), false] isEqualTo false) then { break };
    if (_object getVariable[QGVAR(teleportReturnTimeout), 0] > diag_tickTime) then { continue };

    TRACE_1("return timer timed out; returning object",_object);
    break;
};

if (_object getVariable[QGVAR(teleportOrigin), false] isEqualTo false) exitWith {
    TRACE_1("has no teleport origin",_object);
};

[_object] call FUNC(teleportObjectBack);

nil;
