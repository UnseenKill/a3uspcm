#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_getNearbyVehicles

Description:
    Wrapper function for HALs_store_getNearbyVehicles which is final, so ours
    is just more final.

Parameters:
    0: _trader - Trader guy <OBJECT>

Optional:
    1: _types - Array of vehicle classes to find <ARRAY>
    2: _radius - Radius to search <NUMBER>

Returns:
    <ARRAY> Array of nearby vehicles

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getNearbyVehicles),_this);

if !assert(params[
    ["_trader", objNull, [objNull]]
]) exitWith {[]};

if !assert(!isNull _trader) exitWith {[]};

private _types = param[1, ["LandVehicle", "Air", "Ship", "ReammoBox_F"], [[]]];
private _radius = param[2, HALs_store_containerRadius, [0]];
private _reference = missionNamespace getVariable[QGVAR(nearbyVehiclesReference), _trader];

nearestObjects[_reference, _types, _radius, true]
    select {local _x && {abs speed _x < 1 && {alive _x && isNil {_x getVariable "HALs_store_trader_type"}}}};
