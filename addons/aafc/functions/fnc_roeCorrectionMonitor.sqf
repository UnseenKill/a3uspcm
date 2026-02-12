#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_roeCorrectionMonitor

Description:
    Monitor ROE for all groups and correct if needed

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(roeCorrectionMonitor),_this);

uiSleep GVAR(roeCorrectionInterval);

INFO("Running ROE correction routine...");

// No CBA_EVENT_AAFC_SET_ROE_GLOBAL event here, we don't want tablet UI updating
// while in use...
[GVAR(globalROE)] call FUNC(enforceROE);

[] spawn FUNC(roeCorrectionMonitor);

nil;
