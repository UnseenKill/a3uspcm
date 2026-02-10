#include "script_component.hpp"

GVAR(globalROE) = ROE_HOLDFIRE;

[CBA_EVENT_AAFC_SET_ROE_GLOBAL, {
    if !assert(params[
        ["_newROE", nil, [0]]
    ]) exitWith {};

    GVAR(globalROE) = _newROE;
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_SET_ROE_GLOBAL, { call FUNC(enforceROE) }] call CBA_fnc_addEventHandler;
[CBA_EVENT_AAFC_UNIT_ROE_CHANGED, { call FUNC(acknowledgeROEChange) }] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_UPDATE_GROUP, {
    if !assert(params[
        ["_group", nil, [grpNull]]
    ]) exitWith {};

    units _group apply { objectParent _x } select { !isNull _x } apply {
        _group getVariable QGVAR(vehicles) pushBackUnique _x;

        if !(_x in assignedVehicles _group) then {
            _group addVehicle _x;
        };
    };
}] call CBA_fnc_addEventHandler;

nil;
