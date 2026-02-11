#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_drawVehicleEffectiveRangesMarkers

Description:
    Draw markers for vehicle's effective ranges.

Parameters:
    0: _vehicle - the vehicle object to draw effective range markers for <OBJECT>

Optional:

Returns:
    <ARRAY> Array of created marker names.

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(drawVehicleEffectiveRangesMarkers),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

private["_marker"];
private _markerPos = getPosATL _vehicle;
_markerPos deleteAt [-1];
private _markerPrefix = format["%1_", hashValue _vehicle];
private _markers = [];
private _ranges = [_vehicle] call FUNCMAIN(utilGetVehicleEffectiveRanges);

if !(isNil { _ranges get "sensorsActive" }) then {
    private _sensorsColor = ["#(0,0,0.6)","#(0.5,0.5,1)"] select(_ranges get "sensorsActive");

    if ((_ranges get "sensorsMin") isNotEqualTo (_ranges get "sensorsMax")) then {
        _marker = createMarkerLocal[format["%1_sensorsMin", _markerPrefix], _markerPos];
        _marker setMarkerShapeLocal "ELLIPSE";
        _marker setMarkerBrushLocal "Border";
        _marker setMarkerSizeLocal[_ranges get "sensorsMin", _ranges get "sensorsMin"];
        _marker setMarkerColorLocal _sensorsColor;
        _marker setMarkerAlphaLocal 1;
        _markers pushBack _marker;
    };

    _marker = createMarkerLocal[format["%1_sensorsMax", _markerPrefix], _markerPos];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerBrushLocal "Border";
    _marker setMarkerSizeLocal[_ranges get "sensorsMax", _ranges get "sensorsMax"];
    _marker setMarkerColorLocal _sensorsColor;
    _marker setMarkerAlphaLocal 1;
    _markers pushBack _marker;
};

private _drawMainMarkers = {
    params["_prefix","_markerColor","_crossAngle"];
    if (_ranges get _prefix isEqualTo []) exitWith {};

    private _min = format["%1Min", _prefix];
    private _max = format["%1Max", _prefix];
    private _minRadius = 0;

    if ((_ranges get _min) isNotEqualTo (_ranges get _max)) then {
        _minRadius = _ranges get _min;
        _marker = createMarkerLocal[format["%1_%2Min", _markerPrefix, _prefix], _markerPos];
        _marker setMarkerShapeLocal "ELLIPSE";
        _marker setMarkerBrushLocal "Border";
        _marker setMarkerSizeLocal[_ranges get _min, _ranges get _min];
        _marker setMarkerColorLocal _markerColor;
        _marker setMarkerAlphaLocal 1;
        _markers pushBack _marker;
    };

    _marker = createMarkerLocal[format["%1_%2Max", _markerPrefix, _prefix], _markerPos];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerBrushLocal "Border";
    _marker setMarkerSizeLocal[_ranges get _max, _ranges get _max];
    _marker setMarkerColorLocal _markerColor;
    _marker setMarkerAlphaLocal 1;
    _markers pushBack _marker;

    for "_a" from 0 to 360 step 90 do {
        private _angle = _crossAngle + _a;
        private _lines = [
            [sin _angle, cos _angle] vectorMultiply(_ranges get _min) vectorAdd _markerPos,
            [sin _angle, cos _angle] vectorMultiply(_ranges get _max) vectorAdd _markerPos
        ];

        _marker = createMarkerLocal[format["%1_%2Cross_%3", _markerPrefix, _prefix, _angle], _markerPos];
        _marker setMarkerShapeLocal "POLYLINE";
        _marker setMarkerShadowLocal false;
        _marker setMarkerColorLocal _markerColor;
        _marker setMarkerPolylineLocal flatten _lines;
        _marker setMarkerAlphaLocal 1;
        _markers pushBack _marker;
    };
};

["weaponsMissiles", "#(0.6,0,0)", 0] call _drawMainMarkers;
["weaponsGuns", "#(0.6,0,0.6)", 45] call _drawMainMarkers;

_markers;
