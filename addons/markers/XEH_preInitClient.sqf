#include "script_component.hpp"

[{
    if (player isNotEqualTo theBoss) then {
        LOG("Not the boss, skipping marker restore");
    } else {
        LOG("Player is the boss, asking server to restore markers");
        [CBA_EVENT_SERVER_MARKERS_RESTORE, [player]] call CBA_fnc_serverEvent;
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
