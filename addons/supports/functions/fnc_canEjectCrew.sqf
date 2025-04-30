#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_canEjectCrew

Description:
    Menu callback handler

Parameters:
    0: _vehicle - Vehicle <TYPE>
    1: _player - Caller <TYPE>

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

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

if (crew _vehicle isEqualTo []) exitWith { false };

private _group = group(crew _vehicle select 0);

!(_group in hcAllGroups _player);
