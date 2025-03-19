#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_changeCargoSpace

Description:
    Change the maximum cargo

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>

Optional:
    2: _params - Callback parameters <ARRAY>

Example:

Returns:
    Nothing

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

[localize LSTRING(PromptChangeCargoSpace), str([_vehicle] call FUNCMAIN(utilAceCargoGetCargoSize)), {
    TRACE_1(QFUNC(changeCargoSpace),_this);
    params[["_sizeStr","",[""]],["_vehicle",objNull,[objNull]]];
    private _size = parseNumber _sizeStr;
    [_vehicle, _size] call ace_cargo_fnc_setSpace;

    [
        localize LSTRING(PromptChangeCargoSpace),
        format[localize LSTRING(HintCargoSizeChangedText), getText(configOf _vehicle >> "displayName"), _size]
    ] call A3A_fnc_customHint;
}, _vehicle] call FUNCMAIN(utilPromptText);

nil;
