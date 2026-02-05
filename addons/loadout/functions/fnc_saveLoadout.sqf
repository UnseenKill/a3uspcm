#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_saveLoadout

Description:
    ACE action to save loadout

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>

Optional:
    2: _params - Callback parameters <ARRAY>

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_params", [], [[]]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};

private _loadouts = [] call FUNC(getLoadouts);
private _thisLoadout = [_vehicle] call FUNC(serializeLoadout);

if !(_thisLoadout isEqualType []) exitWith {
    [
        LLSTRING(HintLoadoutSaveCaption),
        LLSTRING(HintLoadoutNotSavedText)
    ] call A3A_fnc_customHint;
};

_loadouts = [_thisLoadout] + _loadouts;

while {count _loadouts > MAX_LOADOUTS} do {
    _loadouts deleteAt (count _loadouts - 1);
};

GVAR(Loadouts) = _loadouts;

[
    LLSTRING(HintLoadoutSaveCaption),
    LLSTRING(HintLoadoutSavedText)
] call A3A_fnc_customHint;

nil;
