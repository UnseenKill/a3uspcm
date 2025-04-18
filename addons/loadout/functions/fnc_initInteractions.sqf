#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_initInteractions

Description:
    Initialize vanilla interactions for loadouts.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initInteractions),_this);

if EGVAR(main,AceHaveAddon) exitWith {};

["AIVehInit", QGVAR(AIVehInit), {
    call FUNC(onAIVehInit);
}] call A3A_Events_fnc_addEventListener;

nil;
