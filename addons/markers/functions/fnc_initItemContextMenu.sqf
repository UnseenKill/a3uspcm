#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_initItemContextMenu

Description:
    Initializes the item context menu for the permanent marker item.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_markers_fnc_initItemContextMenu;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initItemContextMenu),_this);

if !GVAR(allowPersistentMarkers) exitWith { false };

[
    QGVAR(PermanentMarker),
    "UNIFORM_CONTAINER",
    LSTRING(EraseMarkers),
    [],
    QPATHTOEF(assets,ui\loadout-discard.paa),
    { true },
    { call FUNC(eraseMarkers) },
    false
] call CBA_fnc_addItemContextMenuOption;

nil;
