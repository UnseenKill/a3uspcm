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

getArray(configOf _tent >> QGVAR(attachObjects)) apply {
    _x params["_class","_pos","_vdup"];

    private _object = createSimpleObject[_class, [0,0,100], false];
    _object attachTo[_tent, _pos];
    _object setVectorDirAndUp _vdup;
};

_tent addEventHandler["Deleted", {
    TRACE_1(QFUNC(handlerSupportTentPostInit_DeletedEH),_this);
    params["_tent"];

    attachedObjects _tent apply { deleteVehicle _x };
    call FUNC(handlerSupportTentKilled);
}];

_tent addEventHandler["Killed", {
    TRACE_1(QFUNC(handlerSupportTentPostInit_KilledEH),_this);
    params["_tent"];

    attachedObjects _tent apply { _x setDamage 1 };
    call FUNC(handlerSupportTentKilled);
}];

nil;
