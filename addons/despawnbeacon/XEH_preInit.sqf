#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(Entities) = [];

if isServer then {
    ["ace_cargoLoaded", {
        params[["_object", objNull, [objNull,""]]];
        if !(_object in GVAR(Entities)) exitWith {};
        [_object] call FUNC(onBeaconLoaded);
    }] call CBA_fnc_addEventHandler;

    ["ace_cargoUnloaded", {
        params[["_object", objNull, [objNull,""]]];
        if !(_object in GVAR(Entities)) exitWith {};
        [_object] call FUNC(onBeaconUnloaded);
    }] call CBA_fnc_addEventHandler;
};

nil;
