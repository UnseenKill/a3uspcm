#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_canUseLoadoutMenu

Description:
    Callback for ACE3 interaction menu

Parameters:
    0: _target - Interaction vehicle <OBJECT>
    1: _player - Player interacting w/ vehicle <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget, player] call A3USPCM_loadout_fnc_canUseLoadoutMenu;
    (end example)

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_target", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _target) exitWith { false };
if !assert(!isNull _player) exitWith { false };

(alive _target)
#ifdef LOADOUT_REQUIRE_FLAG_PROXIMITY
&&
(nearestObjects[_target, ["Flag_FIA_F"], FIA_FLAG_LOADOUT_RADIUS] isNotEqualTo []);
#endif
