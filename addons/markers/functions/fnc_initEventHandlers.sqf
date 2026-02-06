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

#define ADD_MISSION_EH(eventName,localIndex,func) if true then {\
    addMissionEventHandler[QUOTE(eventName), { \
        TRACE_1(QFUNC(eventName),_this); \
        if (!(_this select localIndex) && {(_this select 0) find "_USER_DEFINED" isEqualTo 0} && {[] call FUNC(canEraseMarkers)}) then {\
            _this remoteExec[QUOTE(func), 2];\
        };\
    }]; \
}

ADD_MISSION_EH(MarkerCreated,3,FUNC(onMarkerCreated));
ADD_MISSION_EH(MarkerDeleted,1,FUNC(onMarkerDeleted));
ADD_MISSION_EH(MarkerUpdated,1,FUNC(onMarkerUpdated));

nil;
