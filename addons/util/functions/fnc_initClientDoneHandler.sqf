#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_fnc_initClientDoneHandler

Description:
    Wait for A3U signaling client initialization, then load loadouts.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initClientDoneHandler),_this);

_this spawn {
    INFO("waiting for A3U client init");
    waitUntil { !isNil "initClientDone" };
    INFO("running client init callbacks");

    GVAR(ClientInitCallbacks) apply {
        [] call _x;
    };

    GVAR(initClientDone) = true;
};

nil;
