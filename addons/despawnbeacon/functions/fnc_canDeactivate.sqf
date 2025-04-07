#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_canDeactivate

Description:
    Check if the despawn beacon can be deactivated.

Parameters:
    0: _beacon - Despawn beacon object <OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget] call A3USPCM_despawnbeacon_fnc_canDeactivate;
    (end example)

Returns:
    Whether the despawn beacon can be deactivated <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_beacon", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

([_player, _beacon] call ace_common_fnc_canInteractWith) && !(call FUNC(canActivate));
