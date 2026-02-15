#include "script_component.hpp"

[] call FUNC(initItemContextMenu);

#define ADD_MISSION_EH(eventName,localIndex,func) if true then { \
    addMissionEventHandler[QUOTE(eventName), { \
        if (GVAR(markersRestored) && { _this select localIndex } && \
                { (_this select 0) find "_USER_DEFINED" isEqualTo 0 } && \
                { [] call FUNC(canEraseMarkers) }) then { \
            TRACE_1(QFUNC(eventName),_this); \
            _this remoteExec[QUOTE(func), 2]; \
        }; \
    }]; \
}

ADD_MISSION_EH(MarkerCreated,3,FUNC(onMarkerCreated));
ADD_MISSION_EH(MarkerDeleted,1,FUNC(onMarkerDeleted));
ADD_MISSION_EH(MarkerUpdated,1,FUNC(onMarkerUpdated));

nil;
