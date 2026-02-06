#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_initItemContextMenu

Description:
    Initialize CBA inventory context menu for assets.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initItemContextMenu),_this);

[
    QGVAR(DecryptKeyBase),
    "ALL",
    LSTRING(Mag_DecryptKeyBase_ReadDocumentsContextMenuLabel),
    [],
    "",
    { true },
    { call FUNC(decryptKeysRead) },
    true
] call CBA_fnc_addItemContextMenuOption;

[
    QGVAR(DecryptKeyRefuse),
    "ALL",
    LSTRING(Mag_DecryptKeyRefuse_ReadDocumentsContextMenuLabel),
    [],
    "",
    [{ true }, { (_this select 2) isEqualTo QGVAR(DecryptKeyRefuse) }],
    { call FUNC(decryptRefuseRead) },
    true
] call CBA_fnc_addItemContextMenuOption;

nil;
