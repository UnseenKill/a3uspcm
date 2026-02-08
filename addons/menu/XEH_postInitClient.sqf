#include "script_component.hpp"

INFO_1(LLSTRING(InitMessage),QUOTE(VERSION_STR));

[{
    if GVAR(autoFixVoices) then {
        INFO("Auto-fixing voices at startup...");

        [] call FUNCMAIN(miscFixVoices);

        player addEventHandler["Respawn", {
            INFO("Auto-fixing voices at respawn...");
            [] call FUNCMAIN(miscFixVoices);
        }];
    };
}] call FUNCMAIN(utilOnA3UClientInitDone);

nil;
