#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_applyPendingFilters

Description:
    Applies any pending filters to the location list

Parameters:
    0: _filterGroup - Filter control group <CONTROL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(applyPendingFilters),_this);

if !assert(params[
    ["_filterGroup", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _filterGroup) exitWith {};

private _abort = !isNil { _filterGroup getVariable QGVAR(pendingFiltersTTL) };
private _display = uiNamespace getVariable QGVAR(display);

_filterGroup setVariable[QGVAR(pendingFiltersTTL), diag_tickTime + 0.75];

TRACE_1("B",_abort);

if (_abort) exitWith {};

waitUntil { isNull _filterGroup || { _filterGroup getVariable QGVAR(pendingFiltersTTL) < diag_tickTime } };

_filterGroup setVariable[QGVAR(pendingFiltersTTL), nil];

private _currentFilters = _display getVariable QGVAR(filters);
private _pendingFilters = _filterGroup getVariable QGVAR(pendingFilters);
_filterGroup setVariable[QGVAR(pendingFilters), nil];

_pendingFilters sort true;

if (_pendingFilters isEqualTo _currentFilters) exitWith {
    LOG_1("no change from pending filters to current filters: %1",_pendingFilters);
};

missionNamespace setVariable[QGVAR(filters), _pendingFilters];
_display setVariable[QGVAR(filters), _pendingFilters];

LOG_1("applied pending filters: %1",_pendingFilters);

[CBA_EVENT_UPDATE_LOCATIONS] call CBA_fnc_localEvent;

nil;
