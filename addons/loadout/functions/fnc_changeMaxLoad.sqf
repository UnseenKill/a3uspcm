#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_changeMaxLoad

Description:
    Change the maximum (inventory) cargo

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

[LLSTRING(PromptChangeMaxLoad), str maxLoad _vehicle, {
    TRACE_1(QFUNC(changeMaxLoad),_this);
    params[["_sizeStr","",[""]],["_vehicle",objNull,[objNull]]];
    private _size = parseNumber _sizeStr;
    _vehicle setMaxLoad _size;

    [
        LLSTRING(PromptChangeMaxLoad),
        format[LLSTRING(HintMaxLoadChangedText), getText(configOf _vehicle >> "displayName"), _size]
    ] call A3A_fnc_customHint;
}, _vehicle] call FUNCMAIN(utilPromptText);

nil;
