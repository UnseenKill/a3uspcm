#include "script_component.hpp"

GVAR(securityReferenceSetting) = player;

[{
    player addEventHandler["Respawn", {
        INFO("Auto-adjusting player reference...");

        // If referencing to something human-like, it can only be the player,
        // so update the reference accordingly, lest units return to the corpse
        // of the previous player object.
        if (!isNull GVAR(securityReferenceSetting) && { GVAR(securityReferenceSetting) isKindOf "CAManBase" }) then {
            GVAR(securityReferenceSetting) = player;
        };
    }];

    player addEventHandler["SlotItemChanged", { call FUNC(onPlayerEventLoadout) }];
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
