#include "script_component.hpp"

TRACE_1(QFUNC(postInitClient),_this);

// <TODO: CBA setting>
// allowOwnershipFilter: <BOOL>
GVAR(allowOwnershipFilter) = true;

// allowUnitDismissal: <BOOL>
GVAR(allowUnitDismissal) = true;

// enemiesCloseCheck: <BOOL>
GVAR(enemiesCloseCheck) = true;

// confirmRecruitment: 0 = never, 1 = only if dismissing units, 2 = always
GVAR(confirmRecruitment) = 2;
// </TODO: CBA setting>

// For populating UI
[CBA_EVENT_DIALOG_BUILT, LINKFUNC(onDialogBuilt)] call CBA_fnc_addEventHandler;

// For event registering
[CBA_EVENT_DIALOG_LOADED, LINKFUNC(onDialogLoaded)] call CBA_fnc_addEventHandler;

// For event unregistering
[CBA_EVENT_DIALOG_UNLOADED, LINKFUNC(onDialogUnloaded)] call CBA_fnc_addEventHandler;

// Keep a cache of colors at to not `compile` them every time they are needed
GVAR(markerColorsCache) = createHashMapFromArray(["colorBLUFOR", "colorOPFOR", "ColorGUER", "ColorCIV", "ColorUNKNOWN"] apply {
    [_x, getArray(configFile >> "CfgMarkerColors" >> _x >> "color") apply { call compile _x }];
});

nil;
