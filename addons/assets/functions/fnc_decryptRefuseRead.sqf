#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_decryptRefuseRead

Description:
    Reread read document.

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
TRACE_1(QFUNC(decryptRefuseRead),_this);

if !assert(params[
    ["_player", nil, [objNull]],
    ["_container", nil, [objNull]],
    ["_documentClass", nil, [""]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

private _class = configFile >> "CfgWeapons" >> _documentClass;
if !assert(isClass _class && { !isNull _class }) exitWith {};

if (GVAR(refuseRereadYieldChance) > (random 100)) then {
    [objNull, objNull, selectRandom[QGVAR(DecryptKeySingle_B), QGVAR(DecryptKeySingle_O)]] call FUNC(decryptKeysRead);

    [getText(_class >> "displayNameShort"), LLSTRING(Mag_DecryptKeyRefuse_HintDocumentRereadRandomYield)] call A3A_fnc_customHint;
    playSound "A3AP_UiSuccess";
} else {
    [getText(_class >> "displayNameShort"), LLSTRING(Mag_DecryptKeyRefuse_HintDocumentRereadNoYield)] call A3A_fnc_customHint;
    playSound "A3AP_UiFailure";
};

if !isNull(_container) then {
    _container addItemCargoGlobal[QGVAR(DecryptKeyRefuseReread), 1];
};

nil;
