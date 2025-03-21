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
if !((alive ACE_player) && (QGVAR(PermanentMarker) in uniformItems ACE_player)) exitWith { false };

switch true do {
    case ("theBoss" isEqualTo GVAR(allowUsageFor)): { player isEqualTo theBoss };
    case ("member" isEqualTo GVAR(allowUsageFor)): { [player] call A3A_fnc_isMember };
    default { true };
};
