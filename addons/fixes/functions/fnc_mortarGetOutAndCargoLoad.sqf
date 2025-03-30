#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_mortarGetOutAndCargoLoad

Description:
    Radio/user action executed on unit mounting a mortar

Parameters:
    0: _unit - Unit to perform cargo loading <OBJECT>
    1: _caller - Unit calling the action (player if per user action, _unit if radio command) <OBJECT>
    2: _actionId - Action ID <STRING>
    3: _params - Additional parameters <ARRAY>
        0: _mortar - Mortar <OBJECT>

Optional:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_unit", objNull, [objNull]],
    ["_caller", objNull, [objNull]],
    ["_actionId", -1, [0]],
    ["_params", [], [[]]]
];

_params params[["_mortar",objNull,[objNull]]];
private _vehicle = _mortar getVariable[QGVAR(cargoLoadVehicle), objNull];

if !assert(!isNull _vehicle) exitWith {};

TRACE_6(QFUNC(mortarGetOutAndCargoLoad),_unit,_caller,_actionId,_vehicle,_mortar,typeOf _mortar);

if !(alive _mortar) exitWith {
    _unit groupRadio "SentSupportNotAvailable";
    _unit groupChat localize LSTRING(Text_Chat_MortarDestroyed);
};

if !(alive _vehicle) exitWith {
    _unit groupRadio "SentSupportNotAvailable";
    _unit groupChat localize LSTRING(Text_Chat_VehicleDestroyed);
};

if (_mortar distance _vehicle > CARGO_LOAD_MAX_DISTANCE) exitWith {
    _unit groupRadio "SentSupportNotAvailable";
    _unit groupChat format[localize LSTRING(Text_Chat_VehicleTooFarAway), CARGO_LOAD_MAX_DISTANCE];
};

_unit groupChat localize LSTRING(Text_Chat_CargoLoadingMortar);

[_unit, _mortar, _vehicle] spawn {
    params[
        ["_unit", objNull, [objNull]],
        ["_mortar", objNull, [objNull]],
        ["_vehicle", objNull, [objNull]]
    ];

    if (objectParent _unit isEqualTo _mortar) then {
        moveOut _unit;
        uiSleep 1.75;
    };

    _unit doMove getPos _mortar;
    uiSleep 0.75;

    TRACE_1(QFUNC(mortarGetOutAndCargoLoad_WaitUntil1),_this);
    waitUntil { moveToCompleted _unit };

    _unit groupRadio "SentConfirmOther";
    [_unit, "MedicOther"] call ace_common_fnc_doGesture;

    uiSleep 3.5;

    if ([_mortar, _vehicle, true] call ace_cargo_fnc_loadItem) then {
        _unit groupRadio "SentSupportDone";
        _unit groupChat localize LSTRING(Text_Chat_MortarCargoLoaded);
    } else {
        _unit groupRadio "SentSupportNotAvailable";
        _unit groupChat localize LSTRING(Text_Chat_MortarCargoLoadFailed);
    };
};

nil;
