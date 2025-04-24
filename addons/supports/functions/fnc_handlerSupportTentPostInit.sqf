#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_handlerSupportTentPostInit

Description:
    Post-init handler for support tents (server side)

Parameters:
    0: _tent - Support tent object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerSupportTentPostInit),_this);

params[
    ["_tent",objNull,[objNull]]
];

if !assert(!isNull _tent) exitWith {};
if !assert(GVAR(tentGuysGroup) isEqualType grpNull) exitWith {};
if !assert(GVAR(supportBuildings) isEqualType createHashMap) exitWith {};

private _supportType = getText(configOf _tent >> QGVAR(supportType));

if !GVAR(requireSupportBuildings) exitWith {
    INFO_1("Support buildings are disabled. Deleting %1",typeOf _tent);
    deleteVehicle _tent;
};

if (_supportType in GVAR(supportBuildings)) exitWith {
    ERROR_1("Found another %1 instance. Deleting.",typeOf _tent);
    deleteVehicle _tent;
};

GVAR(supportBuildings) set[_supportType, _tent];

// Remove from buildable objects
if !isNil "A3A_buildableObjects" then {
    INFO_1("Removing %1 from buildable objects",typeOf _tent);
    
    A3A_buildableObjects = A3A_buildableObjects select {
        _x select 0 isNotEqualTo typeOf _tent
    };
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
    } else {
        deleteVehicle _object;
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
    };
};

_tent addEventHandler["Deleted", {
    TRACE_1(QFUNC(handlerSupportTentPostInit_DeletedEH),_this);
    params["_tent"];

    _tent getVariable QGVAR(attached) apply { deleteVehicle _x };
    attachedObjects _tent apply { deleteVehicle _x };
    call FUNC(handlerSupportTentKilled);
}];

_tent addEventHandler["Killed", {
    TRACE_1(QFUNC(handlerSupportTentPostInit_KilledEH),_this);
    params["_tent"];

    _tent getVariable QGVAR(attached) apply { _x setDamage 1 };
    attachedObjects _tent apply { _x setDamage 1 };
    call FUNC(handlerSupportTentKilled);
}];

nil;
