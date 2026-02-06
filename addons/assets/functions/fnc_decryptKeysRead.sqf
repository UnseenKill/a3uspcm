#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_decryptKeysRead

Description:
    Read the decryption documents to get the decryption keys.

Parameters:
    0: _player - Player reading the document(s) <OBJECT>
    1: _container - Container containing the document(s) being read <OBJECT>
    2: _documentClass - Class name of the document being read <STRING>
    3: _containerSlot - CBA container slot enum <STRING>
    4: _params - Array of parameters passed to the context menu callback <ANY>
    5: _id - Item id in inventory (?) <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(decryptKeysRead),_this);

if !assert(params[
    ["_player", nil, [objNull]],
    ["_container", nil, [objNull]],
    ["_documentClass", nil, [""]]
]) exitWith {};

private _class = configFile >> "CfgMagazines" >> _documentClass;
if !assert(isClass _class && { !isNull _class }) exitWith {};

private _count = getNumber(_class >> "count");
private _side = getNumber(_class >> "side");
private _key = ["invader", "occupants"] select _side;
private _faction = [A3A_faction_inv, A3A_faction_occ] select _side;
_key = format["%1RadioKeys", _key];

private _before = missionNamespace getVariable[_key, 0];

// Avert thine eyes, it's fugly.
private _code = compile format[QUOTE(missionNamespace setVariable[ARR_3(QQUOTE(%1),%1+%2,true)]; publicVariable QQUOTE(%1)), _key, _count];
TRACE_1(QFUNC(decryptKeysRead),_code);
[_code] remoteExecCall["call", 2];

if !isNull(_player) then {
    private _message = [LSTRING(Mag_DecryptKeyBase_HintDocumentReadNewCount), LSTRING(Mag_DecryptKeyBase_HintDocumentsReadNewCount)] select(_count > 1);
    _message = format[localize _message, _faction get "name", _before + _count];

    [getText(_class >> "displayNameShort"), _message] call A3A_fnc_customHint;
    playSound "A3AP_UiSuccess";
};

if !isNull(_container) then {
    _container addItemCargoGlobal[QGVAR(DecryptKeyRefuse), _count];
};

nil;
