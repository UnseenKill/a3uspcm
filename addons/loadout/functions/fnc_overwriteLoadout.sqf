#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_overwriteLoadout

Description:
    Overwrite vehicle loadout with serialized loadout

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>

Optional:
    2: _index - Index of loadout in global array <NUMBER>

Example:

Returns:
    Nothing

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

[_index, _vehicle] spawn {
    params["_index","_vehicle"];

    private _guiCaption = localize LSTRING(HintLoadoutManageCaption);
    private _guiText = format[localize LSTRING(HintLoadoutConfirmOverwriteText), GVAR(Loadouts) select _index select 0];

    if !([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) exitWith {};

    private _thisLoadout = [_vehicle] call FUNC(serializeLoadout);

    GVAR(Loadouts) set[_index, _thisLoadout];
    [QGVAR(Loadouts), GVAR(Loadouts)] call A3A_fnc_setStatVariable;

    [
        localize LSTRING(HintLoadoutManageCaption),
        format[localize LSTRING(HintLoadoutOverwrittenText), GVAR(Loadouts) select _index select 0]
    ] call A3A_fnc_customHint;

    playSound "A3AP_UiSuccess";
};

nil;
