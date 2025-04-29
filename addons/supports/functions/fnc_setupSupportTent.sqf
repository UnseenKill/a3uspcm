#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_setupSupportTent

Description:
    Setup attached support tent entities

Parameters:
    0: _tent - Tent object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(setupSupportTent),_this);

params[
    ["_tent",objNull,[objNull]]
];

if !assert(!isNull _tent) exitWith {};

// Remove from buildable objects
if !isNil "A3A_buildableObjects" then {
    INFO_1("Removing %1 from buildable objects",typeOf _tent);
    
    A3A_buildableObjects = A3A_buildableObjects select {
        _x select 0 isNotEqualTo typeOf _tent
    };
};

_tent getVariable[QGVAR(attached), []] apply {
    detach _x;
    deleteVehicle _x;
};

_tent setVariable[QGVAR(attached), []];

getArray(configOf _tent >> QGVAR(attachObjects)) apply {
    _x params["_class","_pos","_vdup","_isSimple"];

    private _object = if (_isSimple isNotEqualTo 0) then {
        createSimpleObject[_class, [0,0,100], false];
    } else {
        _class createVehicle[0,0,0];
    };

    if !(_object isKindOf "CAManBase") then {
        _object attachTo[_tent, _pos];
        _object setVectorDirAndUp _vdup;
        continue;
    };

    _tent setVariable[QGVAR(specialistClass), typeOf _object];
    deleteVehicle _object;

    private _spawnSpecialist = (!GVAR(requireSpecialists)) || (
        (GVAR(supportSpecialists) isEqualType createHashMap) && 
        (GVAR(supportSpecialists) getOrDefault[_tent getVariable QGVAR(supportType), false] isEqualTo true)
    );

    TRACE_2(QFUNC(setupSupportTent),_spawnSpecialist,_tent);

    if !_spawnSpecialist then {
        INFO_1("Starting specialist mission for support type %1",_tent getVariable QGVAR(supportType));
        [QGVAR(eventSupportStartSpecialistMission), [_tent getVariable QGVAR(supportType), _tent getVariable QGVAR(specialistClass)]] call CBA_fnc_serverEvent;
    } else {
        _object = GVAR(tentGuysGroup) createUnit[_class, [0,0,0], [], 0, "NONE"];
        _object disableAI "MOVE";
        _object disableAI "AUTOTARGET";
        _object setBehaviour "SAFE";
        _object setPosASL (_tent modelToWorld _pos);
        _object setDir (getDir _tent + 180);

        // Put into list of non-attached objects
        _tent getVariable QGVAR(attached) pushBack _object;

        // Don't let them be in sync animating
        [
            {
                params["_object"];
                _object playMoveNow "Acts_A_M01_briefing";
            },
            [_object],
            (random 1000) / 100
        ] call CBA_fnc_waitAndExecute;

        // No tapping shoulders or anything
        if EGVAR(main,AceHaveAddon) then {
            [_object, _object] call ace_common_fnc_claim;
        };

        // Lose support if guy is killed
        _object setVariable[QGVAR(tent), _tent];
        _object addEventHandler["Killed", {
            params["_unit"];
            [QGVAR(eventSupportSpecialistKilled), [_unit]] call CBA_fnc_serverEvent;
        }];
    };
};

nil;
