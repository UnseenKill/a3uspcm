#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_fixLandingLights

Description:
    Landing lights additions to helipads somehow become part of the save and get
    stored in `constructionsX`.

    This function removes them from constructions data and retriggers the
    landing light init on helipads.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(fixLandingLights),_this);

[{
    private _config = [] call EFUNC(misc,augmentHelipadGetConfig);
    private _classes = [getArray(_config >> "patternTypeMap"), [], {
        _x params["","_className"];
        _accumulator pushBack _className;
        _accumulator;
    }] call CBA_fnc_inject;

    TRACE_2(QFUNC(fixLandingLights),_config,_classes);

    if !assert(_classes isNotEqualTo []) exitWith {
        INFO_1("%1(): no landing light classes found, skipping",QFUNC(fixLandingLights));
    };

    private _removeFromConstructions = entities[_classes, []] select {
        TRACE_3(QFUNC(fixLandingLights),_x,_x getVariable QEGVAR(misc,augmentHelipadLight),_x in constructionsToSave);
        (_x in constructionsToSave) || {isNil { _x getVariable QEGVAR(misc,augmentHelipadLight) }};
    };

    TRACE_1(QFUNC(fixLandingLights),_removeFromConstructions);
    constructionsToSave = constructionsToSave - _removeFromConstructions;
    publicVariable "constructionsToSave";

    _removeFromConstructions apply {
        TRACE_1(QFUNC(fixLandingLights),_x);
        deleteVehicle _x;
    };

    [{
        INFO_1("%1(): reaugmenting...",QFUNC(fixLandingLights));
        nearestObjects[petros, ["A3AU_RebHelipad_base_F"], 1500, true] apply { [_x] call EFUNC(misc,augmentHelipad) };
    }, nil, 5] call CBA_fnc_execAfterNFrames;
}, nil, 5] call CBA_fnc_waitAndExecute;

nil;
