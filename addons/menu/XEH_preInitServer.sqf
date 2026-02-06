#include "script_component.hpp"

/*
GVAR(AdditionalBuildables) = nil;
GVAR(AdditionalStatics) = nil;
GVAR(AdditionalUndercoverVehicles) = nil;
GVAR(AdditionalVehicles) = nil;
GVAR(MarkerSizes) = nil;
*/

[{
    [] call FUNC(loadAdditionalBuildables);
    [] call FUNC(loadAdditionalStatics);
    [] call FUNC(loadAdditionalUndercoverVehicles);
    [] call FUNC(loadAdditionalVehicles);
    [] call FUNC(loadMarkerSizes);

    if is3DENPreview exitWith {};

    [] call FUNC(timerRestore);
    [] call FUNC(commanderMenuAppend);
}] call FUNCMAIN(utilOnA3UServerInitDone);

[CBA_EVENT_MENU_SYNCGVAR, {
    if !assert(params[
        ["_player", nil, [objNull]],
        ["_gvarName", nil, [""]],
        ["_value", nil]
    ]) exitWith {};

    if (_player isNotEqualTo theBoss) exitWith { INFO_2("Ignoring syncGVAR event from non-boss player %1 (variable %2)",str name _player,str _gvarName) };
    if (_gvarName find QUOTE(ADDON) isNotEqualTo 0) exitWith { INFO_1("Ignoring syncGVAR event with invalid gvar name %1",str _gvarName) };

    TRACE_2(QFUNC(syncGVAR),_gvarName,_value);
    missionNamespace setVariable[_gvarName, _value, true];
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving game variables");

    if (!isNil QGVAR(AdditionalBuildables) && { GVAR(AdditionalBuildables) isEqualType [] }) then {
        [QGVAR(AdditionalBuildables), +GVAR(AdditionalBuildables)] call A3A_fnc_setStatVariable;
    };

    if (!isNil QGVAR(AdditionalStatics) && { GVAR(AdditionalStatics) isEqualType [] }) then {
        [QGVAR(AdditionalStatics), +GVAR(AdditionalStatics)] call A3A_fnc_setStatVariable;
    };

    if (!isNil QGVAR(AdditionalUndercoverVehicles) && { GVAR(AdditionalUndercoverVehicles) isEqualType [] }) then {
        [QGVAR(AdditionalUndercoverVehicles), +GVAR(AdditionalUndercoverVehicles)] call A3A_fnc_setStatVariable;
    };

    if (!isNil QGVAR(AdditionalVehicles) && { GVAR(AdditionalVehicles) isEqualType [] }) then {
        [QGVAR(AdditionalVehicles), +GVAR(AdditionalVehicles)] call A3A_fnc_setStatVariable;
    };

    if (!isNil QGVAR(MarkerSizes) && { GVAR(MarkerSizes) isEqualType createHashMap }) then {
        [QGVAR(MarkerSizes), +GVAR(MarkerSizes)] call A3A_fnc_setStatVariable;
    };

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
