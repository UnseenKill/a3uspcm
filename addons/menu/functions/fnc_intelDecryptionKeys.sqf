#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_intelDecryptionKeys

Description:
    Change decryption keys for faction.

Parameters:
    0: _faction - faction to change keys for <STRING>

Optional:

Returns:
    Nothing

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(intelDecryptionKeys),_this);

if !assert(params[
    ["_faction", nil, [""]]
]) exitWith {};

private _key = ["invader", "occupants"] select(_faction isEqualTo "west");
_key = format["%1RadioKeys", _key];

[(localize LSTRING(Intel_AddKeysPrompt)) + ":", str(missionNamespace getVariable[_key, 0]), {
    TRACE_1(QFUNCMAIN(intelDecryptionKeys),_this);

    if !assert(params[
        ["_amount", nil, [true, ""]],
        ["_key", nil, [""]]
    ]) exitWith {};

    _amount = parseNumber _amount;
    if (_amount isEqualType false || { _amount < 0 }) exitWith {};

    private _code = compile format[QUOTE(missionNamespace setVariable[ARR_3(QQUOTE(%1),%2,true)]; publicVariable QQUOTE(%1)), _key, _amount];
    TRACE_1(QFUNCMAIN(intelDecryptionKeys),_code);
    [_code] remoteExecCall["call", 2];

    INFO_3("%1 changed %2 to %3",name player,_key,_amount);

    [
        localize LSTRING(Intel_DecryptionKeysChangedCaption),
        format[localize LSTRING(Intel_DecryptionKeysChangedText), _amount]
    ] call A3A_fnc_customHint;
}, _key] call FUNCMAIN(utilPromptText);

nil;
