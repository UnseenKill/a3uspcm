#include "..\script_component.hpp"
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
        ["_vehicle", objNull, [objNull]],
        ["_unloaded", nil, [false]]
    ];

    if !(_object isEqualType objNull) exitWith {};
    if !assert(!isNull _object) exitWith {};
    if !assert(!isNull _vehicle) exitWith {};
    if !(_object isKindOf "StaticWeapon") exitWith {};

    TRACE_1(QFUNC(fixCargoLoadedStaticsMounting),_object);
    _object setVariable["lockedForAI", true, true];

    if (_object isKindOf "StaticMortar") then {
        if (_unloaded) then {
            _vehicle lock 0;
            [_object, _vehicle] call FUNC(mortarCargoLoadAction);
        } else {
            _vehicle lock 2;
            [_object] call FUNC(mortarClearActionsAndEH);
        };

        if !(_object getVariable[QGVAR(hasFlagAction), false]) then {
            _object setVariable[QGVAR(hasFlagAction), true, true];
            [_object, "static"] remoteExec ["A3A_fnc_flagAction", [teamPlayer,civilian], _object];
        };
    };

    nil;
};

["ace_cargoLoaded", {
    params[
        ["_object", objNull, [objNull,""]],
        ["_vehicle", objNull, [objNull]]
    ];

    TRACE_2("ace_cargoLoaded",_object,_vehicle);

    [_object, _vehicle, false] call GVAR(staticsMountedHandler);
}] call CBA_fnc_addEventHandler;

["ace_cargoUnloaded", {
    params[
        ["_object", objNull, [objNull,""]],
        ["_vehicle", objNull, [objNull]],
        ["_unloadType", "", [""]]
    ];

    TRACE_3("ace_cargoUnloaded",_object,_vehicle,_unloadType);

    [_object, _vehicle, true] call GVAR(staticsMountedHandler);
}] call CBA_fnc_addEventHandler;

nil;
