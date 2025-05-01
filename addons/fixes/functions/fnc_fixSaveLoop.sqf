#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_fixSaveLoop

Description:
    Override A3U's `saveLoop` function and throw events for A3USPCM addons

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(fixSaveLoop),_this);

if !isServer exitWith {};

GVAR(orignalSaveLoop) = A3A_fnc_saveLoop;
A3A_fnc_saveLoop = {
    if !savingServer then {
        [QEGVAR(main,eventMainOnSaveGame), []] call CBA_fnc_serverEvent;
    };

    call GVAR(orignalSaveLoop);
};

nil;
