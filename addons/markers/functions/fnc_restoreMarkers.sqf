#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_markers_fnc_restoreMarkers

Description:
    Restore markers from the save.

Parameters:
    0: _player - Player object to restore markers for (should be the boss) <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["_markerId"]
TRACE_1(QFUNC(restoreMarkers),_this);

if !assert(isServer) exitWith {};
if !assert(params[
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

private _ownerId = owner _player;

keys GVAR(storedMarkers) apply {
    private _properties = GVAR(storedMarkers) get _x;

    _x splitString "#" params["_markerPrefix","_markerId"];
    TRACE_3(QFUNC(restoreMarkers),_x,_markerPrefix,_markerId);

    if (_markerPrefix isEqualTo QGVAR(markerId)) then {
        _markerId = format["_USER_DEFINED #%1/%2/1", _ownerId, _markerId];
        GVAR(storedMarkers) deleteAt _x;
        GVAR(storedMarkers) set[_markerId, _properties];
    } else {
        WARNING_1("Keeping out-of-date marker id: %1",_x);
        _markerId = _x;
    };

    TRACE_2(QFUNC(restoreMarkers),_markerId,_properties);

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

GVAR(markersRestored) = true;
publicVariable QGVAR(markersRestored);

nil;
