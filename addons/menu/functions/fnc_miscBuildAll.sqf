#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscBuildAll

Description:
    Build all unbuilt objects instantly.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscBuildAll),_this);

if (A3A_unbuiltObjects isEqualTo []) exitWith {
    INFO("No unbuilt objects to build.");
    playSound "A3AP_UiFailure";
    [LLSTRING(Miscellaneous_BuildAllCaption), LLSTRING(Miscellaneous_BuildAllNoUnbuiltObjects)] call A3A_fnc_customHint;
};

(+A3A_unbuiltObjects) apply {
    INFO_1("Instant building %1",_x);

    [_x, true] remoteExecCall["A3A_fnc_buildingComplete", 2];
};

nil;
