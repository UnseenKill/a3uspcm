#include "script_component.hpp"

GVAR(AdditionalBuildables) = false;
GVAR(AdditionalStatics) = false;
GVAR(AdditionalUndercoverVehicles) = false;
GVAR(AdditionalVehicles) = false;
GVAR(MarkerSizes) = false;

[{
    if is3DENPreview exitWith {};
    [] call FUNC(loadAdditionalBuildables);
    [] call FUNC(loadAdditionalStatics);
    [] call FUNC(loadAdditionalUndercoverVehicles);
    [] call FUNC(loadAdditionalVehicles);
    [] call FUNC(loadMarkerSizes);
    [] call FUNC(timerRestore);
    [] call FUNC(commanderMenuAppend);
}] call FUNCMAIN(utilOnA3UServerInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving game variables");

    [QGVAR(AdditionalBuildables), +GVAR(AdditionalBuildables)] call A3A_fnc_setStatVariable;
    [QGVAR(AdditionalStatics), +GVAR(AdditionalStatics)] call A3A_fnc_setStatVariable;
    [QGVAR(AdditionalUndercoverVehicles), +GVAR(AdditionalUndercoverVehicles)] call A3A_fnc_setStatVariable;
    [QGVAR(AdditionalVehicles), +GVAR(AdditionalVehicles)] call A3A_fnc_setStatVariable;
    [QGVAR(MarkerSizes), +GVAR(MarkerSizes)] call A3A_fnc_setStatVariable;

    [QGVAR(Timers), GVAR(Timers) apply {
        if (_x isEqualType false) then {
            _x;
        } else {
            ASSUME_VARIABLE_TYPE(_x,createHashMap);
            private _data = +_x;
            _data set["handle", false];
            _data;
        };
    }] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;

nil;
