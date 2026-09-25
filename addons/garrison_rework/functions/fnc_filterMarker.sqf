#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_filterMarker

Description:
    Filters a given marker based on the provided filters.

Parameters:
    0: _marker - the marker to be filtered <STRING>
    1: _filters - the filters to apply <ARRAY>

Optional:

Example:

Returns:
    Boolean indicating whether the marker passes the filters <BOOL>

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(filterMarker),_this);

if !assert(params[
    ["_marker", nil, [""]],
    ["_filters", nil, [[]]]
]) exitWith { false };

if (isNil QGVAR(locationFilters)) then {
    GVAR(locationFilters) = compileFinal createHashMapFromArray[
        [FILTER_AT_CAPACITY, { count(garrison getVariable[_this, []]) < ([_this] call A3A_fnc_getGarrisonLimit) }],
        [FILTER_BASES, { _this in(milbases + airportsX + seaports + ["Synd_HQ"]) }],
        [FILTER_OUTPOSTS, { _this in outposts }],
        [FILTER_OWNER_INVADERS, { true }],
        [FILTER_OWNER_OCCUPIERS, { true }],
        [FILTER_OWNER_REBELS, { true }],
        [FILTER_POSTS, { _this in(aapostsFIA + atpostsFIA + hmgpostsFIA + roadblocksFIA) }],
        [FILTER_RESOURCES, { _this in(resourcesX + factories) }],
        [FILTER_TOWNS, { _this in citiesX }]
    ];
};

private _match = _filters select {
    _marker call(GVAR(locationFilters) getOrDefault[_x, { false }]);
};

_match sort true;

if (_match isNotEqualTo _filters) exitWith { false };

private _markerVisible = (!hideEnemyMarkers || { markerAlpha _marker > 0 });

((FILTER_OWNER_REBELS in _filters) && { sidesX getVariable[_marker, sideUnknown] isEqualTo resistance }) ||
{ (FILTER_OWNER_OCCUPIERS in _filters) && { _markerVisible && { sidesX getVariable[_marker, sideUnknown] isEqualTo west } } } ||
{ (FILTER_OWNER_INVADERS in _filters) && { _markerVisible && { sidesX getVariable[_marker, sideUnknown] isEqualTo east } } };
