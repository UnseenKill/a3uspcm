#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_recruitLaunchAGM

Description:
    Launch advanced garrison manager

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_recruitLaunchAGM;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(recruitLaunchAGM),_this);
createDialog QEGVAR(garrison,dialog);

nil;
