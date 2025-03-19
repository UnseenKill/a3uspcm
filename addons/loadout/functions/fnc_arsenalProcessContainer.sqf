#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_arsenalProcessContainer

Description:
    Either discard or unlock items from container

Parameters:
    0: _container - Container object <OBJECT>
    1: _unlock - Unlock (TRUE) or discard (FALSE) items <BOOL>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(arsenalProcessContainer),_this);

params[
    ["_container", objNull, [objNull]],
    ["_unlock", true, [true]]
];

if !assert(!isNull _container) exitWith { false };

private _items = [_container] call FUNC(utilContainerContentFlattened);

keys _items apply {
    [_x, false, _unlock] call FUNCMAIN(utilUnlockArsenalItem);
};

[_container, _unlock] spawn {
    params["_container","_unlock"];

    private _guiCaption = localize([LSTRING(ArsenalDiscard), LSTRING(ArsenalUnlock)] select _unlock);
    private _guiText = localize LSTRING(ArsenalProcessContainerCleanConfirm);

    if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
        clearBackpackCargoGlobal _container;
        clearItemCargoGlobal _container;
        clearMagazineCargoGlobal _container;
        clearWeaponCargoGlobal _container;
    };
};

nil;
