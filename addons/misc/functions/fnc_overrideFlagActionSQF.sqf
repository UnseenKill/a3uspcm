#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_overrideFlagActionSQF

Description:
    Overrides A3U `A3A_fnc_flagAction` so we can hook into it.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(overrideFlagActionSQF),_this);

waitUntil { !isNil "A3A_fnc_flagAction" };

INFO("Hooking into A3A_fnc_flagAction ...");

GVAR(A3A_fnc_flagAction) = A3A_fnc_flagAction;
A3A_fnc_flagAction = {
    call GVAR(A3A_fnc_flagAction);
    [CBA_EVENT_A3U_FLAGACTION, _this] call CBA_fnc_localEvent;
};

nil;
