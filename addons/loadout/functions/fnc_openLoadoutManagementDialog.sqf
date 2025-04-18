#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_openLoadoutManagementDialog

Description:
    Open the loadout management dialog

Parameters:
    0: _vehicle - Vehicle to manage loadout for <OBJECT>
    1: _player - Player doing the call <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(openLoadoutManagementDialog),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};

GVAR(vehicle) = _vehicle;
createDialog QGVAR(Dialog);

nil;
