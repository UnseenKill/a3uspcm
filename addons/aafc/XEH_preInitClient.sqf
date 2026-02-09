#include "script_component.hpp"

GVAR(globalROE) = ROE_HOLDFIRE;

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
