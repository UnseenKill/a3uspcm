#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_trackContact

Description:
    Track a contact for an AA group

Parameters:
    0: _unit - Unit to track <OBJECT>
    1: _key - Unique key for the contact <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(trackContact),_this);

if !assert(params[
    ["_unit", objNull, [objNull]],
    ["_key", nil, [""]]
]) exitWith {};

if !assert(!isNull _unit) exitWith {};

private _marker = createMarker[[] call FUNCMAIN(utilGenerateUniqueID), getPosATL _unit];
private _color = switch side _unit do {
    case west: { "ColorWEST" };
    case east: { "ColorEAST" };
    case independent: { "ColorGUER" };
    default { "ColorUNKNOWN" };
};

private _type = switch true do {
    case (_unit isKindOf "Helicopter"): { "loc_heli" };
    case (_unit isKindOf "Plane"): { "loc_plane" };
    default { "mil_start_noShadow" };
};

_marker setMarkerColorLocal _color;
_marker setMarkerTypeLocal _type;
_marker setMarkerDirLocal getDir _unit;
_marker setMarkerTextLocal DISPLAY_NAME_UNIT(_unit);
_marker setMarkerAlpha 1;

GVAR(contacts) set[_key, createHashMapFromArray[
    ["unit", _unit],
    ["key", _key],
    ["marker", _marker],
    ["alive", alive _unit],
    ["lastPos", getPosATL _unit],
    ["lastDir", getDir _unit],
    ["lastSpeed", speed _unit],
    ["nextUpdate", diag_tickTime + GVAR(contactUpdateInterval)]
]];
publicVariable QGVAR(contacts);

[] call FUNC(updateContactTracks);

nil;
