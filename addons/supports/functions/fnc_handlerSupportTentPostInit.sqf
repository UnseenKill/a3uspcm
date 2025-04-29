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

if !GVAR(requireSupportBuildings) exitWith {
    INFO_1("Support buildings are disabled. Deleting %1",typeOf _tent);
    deleteVehicle _tent;
};

if !(isNil "A3A_building_EHDB") exitWith {
    INFO_1("Tent %1 created in base builder. Doing nothing.",typeOf _tent);
};

private _supportType = getText(configOf _tent >> QGVAR(supportType));

if (_supportType in GVAR(supportBuildings)) exitWith {
    ERROR_1("Found another %1 instance. Deleting.",typeOf _tent);
    deleteVehicle _tent;
};

GVAR(supportBuildings) set[_supportType, _tent];
_tent setVariable[QGVAR(supportType), _supportType];

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

// Support tents are set up after loading the save data, but any other tent
// created afterwards via builder needs to be set up explicitly.
if EGVAR(utils,initClientDone) then {
    [_tent] call FUNC(setupSupportTent);
};

nil;
