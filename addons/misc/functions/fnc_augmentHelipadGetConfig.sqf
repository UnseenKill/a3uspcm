#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_augmentHelipadGetConfig

Description:
    Retrieve addon config for augmenting helipads with landing lights.

Parameters:

Optional:

Returns:
    <CONFIG> Config entry for augmenting helipads

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(augmentHelipadGetConfig),_this);

configFile >> QPREFIX >> QADDON >> "AugmentHelipads";
