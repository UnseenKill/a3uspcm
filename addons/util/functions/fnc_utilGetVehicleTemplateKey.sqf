#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilGetVehicleTemplateKey

Description:
    Returns the A3U vehicle template key for the given vehicle class/object.

Parameters:
    0: _vehicleClassOrObject - Vehicle class or object <STRING,OBJECT>

Optional:

Example:
    (begin example)
    ["Offroad_Armed"] call A3USPCM_fnc_utilGetVehicleTemplateKey;
    (end example)

Returns:
    <STRING> Vehicle template key

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(utilGetVehicleTemplateKey),_this);

if !assert(params[
    ["_vehicle", nil, ["", objNull]]
]) exitWith {""};

if (_vehicle isEqualType objNull && { !assert(!isNull _vehicle) }) exitWith {""};

private _isArmed = [_vehicle] call FUNCMAIN(utilIsArmedVehicle);

switch true do {
    case (_isArmed && {_vehicle isKindOf "Car"});
    case (_vehicle isKindOf "Tank"): { "vehiclesLightArmed" };
    case (_vehicle isKindOf "Helicopter"): { ["vehiclesCivHeli","vehiclesPlane"] select _isArmed };
    case (_vehicle isKindOf "Plane"): { ["vehiclesCivPlane","vehiclesPlane"] select _isArmed };
    case (_vehicle isKindOf "Ship"): { ["vehiclesCivBoat","vehiclesBoat"] select _isArmed };
    default { "vehiclesCivCar" };
};
