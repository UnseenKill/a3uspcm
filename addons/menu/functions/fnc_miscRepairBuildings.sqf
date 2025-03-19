#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscRepairBuildings

Description:
    Repair damaged buildings around player position.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscRepairBuildings;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 wants buildings repaired",name player);

destroyedBuildings inAreaArray[player, 200, 200, 0, true] apply {
    TRACE_3("repairing building",_x,getPos _x,typeOf _x);
    [_x, true] remoteExec["A3A_fnc_repairRuinedBuilding", 2];
};

nil;
