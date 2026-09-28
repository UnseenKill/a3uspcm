#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_recruitLaunchAGM

Description:
    Launch advanced garrison manager

Parameters:

Optional:
    0: _location - The location to preselect <STRING>

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

if (EGVAR(garrison,useTraditionalAGM)) then {
    call EFUNC(garrison,openManager);
} else {
    call EFUNC(garrison_rework,openManager);
};

nil;
