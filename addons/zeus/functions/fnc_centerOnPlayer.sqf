#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_centerOnPlayer

Description:
    Center the Zeus camera on the player position.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(centerOnPlayer),_this);

if (isNull findDisplay 312) exitWith {};

[curatorCamera, getPosATL player, player] call FUNCMAIN(utilCenterCamera);

nil;
