#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_initClientDoneHandler

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

    INFO("loading stored loadouts");
    [] call FUNC(getLoadouts)
};

nil;
