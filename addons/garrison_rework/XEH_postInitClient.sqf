#include "script_component.hpp"

TRACE_1(QFUNC(postInitClient),_this);

[CBA_EVENT_DIALOG_BUILT, {
    TRACE_1(CBA_EVENT_DIALOG_BUILT,_this);
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_DIALOG_LOADED, {
    TRACE_1(CBA_EVENT_DIALOG_LOADED,_this);
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_DIALOG_UNLOADED, {
    TRACE_1(CBA_EVENT_DIALOG_UNLOADED,_this);
}] call CBA_fnc_addEventHandler;

nil;
