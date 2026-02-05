#include "script_component.hpp"

INFO("A3U fixes post-init (client)");

[] call FUNC(halsStoreDialogInit);
[] spawn FUNC(buyVehicleDialogInit);

if GVAR(noBuyVehicleCooldown) then {
    [CBA_EVENT_CLIENT_BUYVEHICLEDIALOG_BEFORE, {
        player setVariable["A3A_spawnItem_cooldown", 0];
    }] call CBA_fnc_addEventHandler;
};

nil;
