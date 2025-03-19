#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_renameLoadout

Description:
    ACE action to rename a loadout

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>

Optional:
    2: _index - Index of loadout in global array <NUMBER>

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_index", -1, [0]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};
if !assert(!(GVAR(Loadouts) isEqualType false)) exitWith {};

private _lo = GVAR(Loadouts) select _index;

[localize LSTRING(PromptRenameLoadout), _lo select 0, {
    params["_name","_index"];

    GVAR(Loadouts) select _index set[0, _name];
    [QGVAR(Loadouts), GVAR(Loadouts)] call A3A_fnc_setStatVariable;

    [
        localize LSTRING(HintLoadoutManageCaption),
        format[localize LSTRING(HintLoadoutRenamedText), _name]
    ] call A3A_fnc_customHint;
}, _index] call FUNCMAIN(utilPromptText);

nil;
