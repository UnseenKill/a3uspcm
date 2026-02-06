#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_initEventHandlers

Description:
    Initialize marker creation/deletion event handlers.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_markers_fnc_initEventHandlers;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if !isServer exitWith {};

TRACE_1(QFUNC(initEventHandlers),_this);

if !GVAR(allowPersistentMarkers) exitWith { false };

[CBA_EVENT_SERVER_MARKERS_RESTORE, {
    if !assert(params[
        ["_player", nil, [objNull]]
    ]) exitWith {};

    if GVAR(markersRestored) exitWith { INFO("Markers already restored, skipping...") };

    [_player] call FUNC(restoreMarkers);
}] call CBA_fnc_addEventHandler;

nil;
