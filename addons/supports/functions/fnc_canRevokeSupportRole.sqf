#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_canRevokeSupportRole

Description:
    Callback function to check if the revoke support role can be used.

Parameters:
    0: _vehicle - Target <OBJECT>
    1: _player - Caller <OBJECT>

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

_vehicle getVariable[QGVAR(supportType), false] isNotEqualTo false
