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

    TRACE_1(QFUNC(fixLandingLights),_classes);
    private _removeFromConstructions = [entities[_classes, [], false, true], [], {
        TRACE_2(QFUNC(fixLandingLights),_x,_x in constructionsX);
        if (_x in constructionsX) then {
            _accumulator pushBack _x;
            deleteVehicle _x;
        };

        _accumulator;
    }] call CBA_fnc_inject;

    TRACE_1(QFUNC(fixLandingLights),_removeFromConstructions);
    constructionsX = constructionsX - _removeFromConstructions;
    constructionsToSave = constructionsToSave - _removeFromConstructions;
    publicVariable "constructionsToSave";

    entities[["A3AU_RebHelipad_base_F"], []] apply { [_x] call EFUNC(misc,augmentHelipad) };
}, nil, 20] call CBA_fnc_waitAndExecute;

nil;
