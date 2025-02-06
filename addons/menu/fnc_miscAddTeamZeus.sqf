#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscAddTeamZeus

Description:
    Add team members to curatable objects.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscAddTeamZeus;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 wants team added to Zeus objects",name player);

allCurators apply {
    _x addCuratorEditableObjects[units group player, true];
    _x addCuratorEditableObjects[[vehicle player, player], true];
};

nil;
