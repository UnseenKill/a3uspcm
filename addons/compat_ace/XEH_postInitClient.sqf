#include "script_component.hpp"

if EGVAR(menu,autoReinstateWakeUp) then {
    ["ace_medical_WakeUp", {
        TRACE_1(QFUNC(miscReinstateWakeUp),_this);

        if (_this isEqualTo player) then {
            [FUNCMAIN(miscReinstateLeadership), nil, 2.5] call CBA_fnc_waitAndExecute;
        };
    }] call CBA_fnc_addEventHandler;
};

["ace_unconscious", { call FUNC(onAceMedicalUnconscious) }] call CBA_fnc_addEventHandler;
["ace_medical_treatment_bandaged", {
    TRACE_1(QFUNC(onBandaged),_this);
    params["_medic","_patient"];

    if (_patient isEqualTo player && {_medic isEqualTo _patient}) then {
        if (isNil {_patient getVariable QGVAR(hasStableVitals)}) exitWith {};
        _this set[7, 5]; // magic hyper-efficiency
        TRACE_1(QFUNC(onBandaged),_this);
    };
}] call CBA_fnc_addEventHandler;

nil;
