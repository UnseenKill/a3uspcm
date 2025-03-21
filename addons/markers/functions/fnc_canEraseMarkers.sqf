#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_canEraseMarkers

Description:
    Checks if the player can erase markers.

Parameters:

Optional:

Example:

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
(alive ACE_player) && (QGVAR(PermanentMarker) in uniformItems ACE_player);
