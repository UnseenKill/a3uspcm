#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_fnc_initServerDoneHandler

Description:
    Wait for A3U signaling server initialization, then execute callbacks.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initServerDoneHandler),_this);

_this spawn {
    INFO("waiting for A3U server init");
    waitUntil { !isNil "initServerDone" };
    INFO("running server init callbacks");

    GVAR(ServerInitCallbacks) apply {
        [] call _x;
    };

    GVAR(initServerDone) = true;
    publicVariable QGVAR(initServerDone);
};

nil;
