#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_intelGain

Description:
    Gains intel for the player.

Parameters:
    0: _intelType - Type of intel Small|Medium|Large <STRING>
    1: _side - Side name of intel <STRING>

Optional:

Returns:
    Nothing

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(intelGain),_this);

if !assert(params[
    ["_intelType", nil, [""]],
    ["_side", nil, [""]]
]) exitWith {};

[_intelType, [east, west] select(_side isEqualTo "west")] call A3A_fnc_selectIntel;

nil;
