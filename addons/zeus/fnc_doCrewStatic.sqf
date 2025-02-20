#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_doCrewStatic

Description:
    Crew vehicles with a gunner.

Parameters:
    0: _vehicles - Array of vehicles to crew

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicles", [], [[]]]
];

private _group = createGroup independent;

_vehicles apply {
    crew _x apply { moveOut _x };

    [_group, _x] spawn {
        uiSleep 0.5;
        params["_group","_vehicle"];
        private _unit = _group createUnit["I_crew_F", getPosATL _vehicle, [], 0, "NONE"];
        
        _unit moveInGunner _vehicle;
        _unit setSkill 1;
        _vehicle setVariable[QGVAR(crewed), true, true];

        TRACE_2("Crewed static",_vehicle,_unit);

        allCurators apply {
            _x addCuratorEditableObjects[[_vehicle], true];
        };
    };
};

nil;
