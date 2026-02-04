#include "script_component.hpp"

if (!is3DEN && { assert(!isNil "HALs_store_fnc_initServer") }) then {
    INFO("Hooking into HALs_store_fnc_initServer.");

    GVAR(HALs_store_fnc_initServer) = HALs_store_fnc_initServer;
    HALs_store_fnc_initServer = {
        // We're the first final, so jog off.
        missionNamespace setVariable["HALs_store_getNearbyVehicles", compileFinal QUOTE(call FUNC(getNearbyVehicles)), true];
        call GVAR(HALs_store_fnc_initServer);
    };
};
