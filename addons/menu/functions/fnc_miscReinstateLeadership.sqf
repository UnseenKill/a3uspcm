#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscReinstateLeadership

Description:
    Reinstate leadership of a group to the player.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscReinstateLeadership;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscReinstateLeadership),_this);

INFO_1("'%1' wants group leadership back",name player);

group player selectLeader player;

nil;
