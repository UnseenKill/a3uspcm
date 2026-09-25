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
        [FILTER_BASES, { _this in(milbases + airportsX + seaports + ["Synd_HQ"]) }],
        [FILTER_OUTPOSTS, { _this in outposts }],
        [FILTER_POSTS, { _this in(aapostsFIA + atpostsFIA + hmgpostsFIA + roadblocksFIA) }],
        [FILTER_RESOURCES, { _this in(resourcesX + factories) }],
        [FILTER_TOWNS, { _this in citiesX }]
    ];
};

if (_filters findIf {
    _marker call(GVAR(locationFilters) getOrDefault[_x, { false }]);
} isEqualTo -1) exitWith { false };

if (FILTER_AT_CAPACITY in _filters && { count(garrison getVariable[_marker, []]) >= ([_marker] call A3A_fnc_getGarrisonLimit) }) exitWith { false };

true;
