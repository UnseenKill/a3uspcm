#include "script_component.hpp"

GVAR(securityReferenceSetting) = player;

[{
    player addEventHandler["Respawn", {
        params["_newUnit"];

        INFO("Auto-adjusting player reference...");

        // If referencing to something human-like, it can only be the player,
        // so update the reference accordingly, lest units return to the corpse
        // of the previous player object.
        if (!isNull GVAR(securityReferenceSetting) && { GVAR(securityReferenceSetting) isKindOf "CAManBase" }) then {
            GVAR(securityReferenceSetting) = _newUnit;
        };

        // If respawning, wait longer until we possibly unassign the menu, so it
        // retains its "order" (i.e. artillery-menu won't shift onto its position)
        if (_newUnit getVariable[QGVAR(lastRadioEquipped), false]) then {
            INFO("Old unit had radio equipped, waiting longer to unassign menu...");
            
            missionNamespace setVariable[QGVAR(waitAndExecuteDelay), 30];

            // Many of the triggers of "onPlayerEventLoadout" are involuntary.
            // E.g. when reequipping after respawn, a lot of items get
            // (un)assigned. If, however, the player opens the inventory, we
            // reset the above generous delay, so changes are "immediate" again.
            _newUnit setVariable[QGVAR(ehInventoryOpened), _newUnit addEventHandler["InventoryOpened", {
                missionNamespace setVariable[QGVAR(waitAndExecuteDelay), 3];
                player removeEventHandler["InventoryOpened", player getVariable QGVAR(ehInventoryOpened)];
                player setVariable[QGVAR(ehInventoryOpened), nil];
            }]];
        };
    }];

    player addEventHandler["SlotItemChanged", { [_this select 0] call FUNC(onPlayerEventLoadout) }];

    [{
        [player] call FUNC(onPlayerEventLoadout);
    }, nil, 10] call CBA_fnc_waitAndExecute;
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
