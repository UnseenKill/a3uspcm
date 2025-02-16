#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_fixCargoLoadedStaticsMounting

Description:
    Fixes issue where garrison soldiers are mounting cargoloaded statics.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fixes_fnc_fixCargoLoadedStaticsMounting;
    (end example)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if !isServer exitWith {};

INFO("starting cargo loaded statics mount fixes");

GVAR(staticsMountedHandler) = {
    params[
        ["_object", objNull, [objNull,""]],
        ["_vehicle", objNull, [objNull]]
    ];

    if !(_object isEqualType objNull) exitWith {};
    if !assert(!isNull _object) exitWith {};
    if !assert(!isNull _vehicle) exitWith {};
    if !(_object isKindOf "StaticWeapon") exitWith {};
    if (_object getVariable[QGVAR(eh_GetIn), false] isNotEqualTo false) exitWith {};

    INFO_1("adding 'GetIn' event handler to %1",_object);

    private _ehid = _object addEventHandler["GetIn", {
        params["_vehicle", "_role", "_unit", "_turret"];
        TRACE_4("GetIn",_vehicle,_role,_unit,_turret);

        if (_unit in playableUnits) exitWith { INFO_2("unit %1 may mount %2",_unit,_vehicle) };
        if (playableUnits findIf { _unit in (units group _x) } >= 0) exitWith { INFO_2("unit %1 may mount %2",_unit,_vehicle) };

        INFO_2("unit %1 may NOT mount %2",_unit,_vehicle);
        moveOut _unit;
    }];

    _object setVariable[QGVAR(eh_GetIn), _ehid, true];

    nil;
};

["ace_cargoLoaded", {
    params[
        ["_object", objNull, [objNull,""]],
        ["_vehicle", objNull, [objNull]]
    ];

    TRACE_2("ace_cargoLoaded",_object,_vehicle);

    [_object, _vehicle] call GVAR(staticsMountedHandler);
}] call CBA_fnc_addEventHandler;

["ace_cargoUnloaded", {
    params[
        ["_object", objNull, [objNull,""]],
        ["_vehicle", objNull, [objNull]],
        ["_unloadType", "", [""]]
    ];

    TRACE_3("ace_cargoUnloaded",_object,_vehicle,_unloadType);

    [_object, _vehicle] call GVAR(staticsMountedHandler);
}] call CBA_fnc_addEventHandler;

nil;
