#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USCP_fnc_miscEnlargeNearestMarker

Description:
    This function enlarges the nearest marker on the map to a specified size.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(miscEnlargeNearestMarker),_this);

private _sites = markersX select { sidesX getVariable[_x, sideUnknown] == teamPlayer };
private _markerX = [_sites, player] call BIS_fnc_nearestPosition;

[format[localize LSTRING(Miscellaneous_EnlargeNearestMarkerPrompt), _markerX], str ((markerSize _markerX select 0) max (markerSize _markerX select 1)), {
    params["_amount","_markerX"];

    _amount = parseNumber _amount;
    if (_amount isEqualType false || 0 == _amount) exitWith {};

    _markerX setMarkerSize[_amount, _amount];

    systemChat "Done";
}, _markerX] call FUNCMAIN(utilPromptText);

nil;
