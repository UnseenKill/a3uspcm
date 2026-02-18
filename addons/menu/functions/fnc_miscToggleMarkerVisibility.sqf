#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscToggleMarkerVisibility

Description:
    Toggle nearest map marker's visibility.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscToggleMarkerVisibility),_this);

private _nearestMarker = [markersX, position player] call BIS_fnc_nearestPosition;

// Shouldn't happen, but just in case
if !assert(_nearestMarker isEqualType "") exitWith {};

private _params = if (markerAlpha _nearestMarker > 0) then {
    [LLSTRING(Miscellaneous_ToggleMarkerVisibilityMessageHidden), 0];
} else {
    [LLSTRING(Miscellaneous_ToggleMarkerVisibilityMessageVisible), 1];
};

_params params["_message","_alpha"];
_nearestMarker setMarkerAlphaLocal _alpha;
[LLSTRING(Miscellaneous_ToggleMarkerVisibilityCaption), format[_message, str _nearestMarker]] call A3A_fnc_customHint;

nil;
