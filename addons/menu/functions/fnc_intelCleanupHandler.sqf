#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_intelCleanupHandler

Description:
    Internal handler to clean up intel markers after a while

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_menu_fnc_intelCleanupHandler;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if GVAR(IntelCleanup) exitWith {};
GVAR(IntelCleanup) = true;

[] spawn {
    INFO("starting intel marker cleanup");

    while { (count GVAR(IntelMarkers)) > 0 } do {
        uiSleep INTEL_CLEANUP_INTERVAL;
        TRACE_1(QFUNC(intelCleanupHandler),diag_tickTime);

        {
            _y params["_created","_icon","_object","_flag"];

            if (_created + GVAR(findIntelMarkerTTL) < diag_tickTime) then {
                TRACE_1("cleaning up intel marker",_x);
                [_x] call FUNC(intelCleanupMarker);
            };

        } forEach GVAR(IntelMarkers);
    };

    INFO("no more intel markers to clean up");
    GVAR(IntelCleanup) = false;
};

nil;
