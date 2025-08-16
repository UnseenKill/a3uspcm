#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_restoreMarkers

Description:
    Restore markers from the save.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(restoreMarkers),_this);

GVAR(storedMarkers) apply {
	private _counter = ({ 0 isEqualTo (_x find "_USER_DEFINED ") } count allMapMarkers);
    private _markerId = format["_USER_DEFINED #%1/%2/1", owner theBoss, _counter];
    private _properties = _y;

	GVAR(markerNameMapping) set[_markerId, _x];

    TRACE_4(QFUNC(restoreMarkers),_x,_counter,_markerId,_properties);

	private _marker = createMarker[_markerId, _properties select 6];

	_marker setMarkerAlphaLocal (_properties select 0);
	_marker setMarkerBrushLocal (_properties select 1);
	//_marker setMarkerChannelLocal (_properties select 2);
	_marker setMarkerColorLocal (_properties select 3);
	_marker setMarkerDirLocal (_properties select 4);
	if (_properties select 5 isNotEqualTo []) then {
		_marker setMarkerPolylineLocal (_properties select 5);
	};
	//_marker setMarkerPos (_properties select 6);
	_marker setMarkerShadowLocal (_properties select 7);
	_marker setMarkerShapeLocal (_properties select 8);
	_marker setMarkerSizeLocal (_properties select 9);
	_marker setMarkerTextLocal (_properties select 10);
	_marker setMarkerType (_properties select 11);
};

nil;
