#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_despawnbeacon_fnc_initItemContextMenu

Description:
    Initializes the item context menu for the permanent marker item.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_despawnbeacon_fnc_initItemContextMenu;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initItemContextMenu),_this);

[
    QGVAR(PackedBeacon),
    ["BACKPACK_CONTAINER","VEST_CONTAINER","UNIFORM_CONTAINER"],
    LSTRING(ActionBeaconUnpackText),
    [],
    "",
    { [player] call FUNC(canUnpack) },
    { [player] call FUNC(unpackBeacon) },
    false
] call CBA_fnc_addItemContextMenuOption;

nil;
