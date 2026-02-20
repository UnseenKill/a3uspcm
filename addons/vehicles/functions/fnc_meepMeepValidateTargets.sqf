#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepValidateTargets

Description:
    Validate targets array for meep meep valid targets.

Parameters:
    0: _target - The target unit (vehicle) <OBJECT>
    1: _units - The array of units to validate <ARRAY>

Optional:

Returns:
    <ARRAY,BOOL> An array of valid targets or `false` if everything was 
        filtered out.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepValidateTargets),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_units", nil, [[]]]
]) exitWith {};
if !assert(!isNull _target) exitWith {[]};

if (_units isEqualTo []) exitWith {[]};

private _filtered = _units select {
    _x params["_unit"];
    (insideBuilding _unit isEqualTo 0) && {
        (getPosASL _unit select 2) < (getTerrainHeightASL getPosASL _unit + 1)
    };
};

if (_filtered isEqualTo []) exitWith {[]};

_filtered = _filtered select {
    _x params["_unit"];

    switch true do {
        case (_unit isEqualTo petros): {
            [_target, LLSTRING(MeepMeep_AnnouncePetrosAintGonnaMove_Text), false, petros] call FUNC(meepMeepFeedback);
        };
        case !(side _unit in[side _target, civilian]): {
            [_target, format[LLSTRING(MeepMeep_AnnounceCommanderHostile_Text), [side _unit] call BIS_fnc_sideName, getText(configOf _unit >> "displayName")], false] call FUNC(meepMeepFeedback);
        };

        default { true };
    };
};

[_filtered, false] select(_filtered isEqualTo []);
