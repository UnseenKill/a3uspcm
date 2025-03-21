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
TRACE_1(QFUNC(initEventHandlers),_this);

if !hasInterface exitWith {};
if !GVAR(allowPersistentMarkers) exitWith { false };

#define BAIL_OUT_OR_CALL(localIndex,func) if true then {\
    if ((_this select localIndex) && ((_this select 0) find "_USER_DEFINED" isEqualTo 0) && ([] call FUNC(canEraseMarkers))) then {\
        _this remoteExec[QUOTE(func), 2];\
    };\
}

addMissionEventHandler["MarkerCreated", {
    BAIL_OUT_OR_CALL(3,FUNC(onMarkerCreated));
}];

addMissionEventHandler["MarkerDeleted", {
    BAIL_OUT_OR_CALL(1,FUNC(onMarkerDeleted));
}];

addMissionEventHandler["MarkerUpdated", {
    BAIL_OUT_OR_CALL(1,FUNC(onMarkerUpdated));
}];

nil;
