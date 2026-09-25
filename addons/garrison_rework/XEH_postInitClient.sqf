#include "script_component.hpp"

TRACE_1(QFUNC(postInitClient),_this);

// For populating UI
[CBA_EVENT_DIALOG_BUILT, LINKFUNC(onDialogBuilt)] call CBA_fnc_addEventHandler;

// For event registering
[CBA_EVENT_DIALOG_LOADED, LINKFUNC(onDialogLoaded)] call CBA_fnc_addEventHandler;

// For event unregistering
[CBA_EVENT_DIALOG_UNLOADED, LINKFUNC(onDialogUnloaded)] call CBA_fnc_addEventHandler;

nil;
