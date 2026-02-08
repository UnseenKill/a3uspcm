#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilIsArmedVehicle

Description:
    Checks if the vehicle is armed or not.

Parameters:
    0: _vehicle - Vehicle class or object <STRING,OBJECT>

Optional:

Example:
    (begin example)
    [cursorTarget] call A3USPCM_fnc_utilIsArmedVehicle;
    (end example)

Returns:
    <BOOL> - True if the vehicle is armed, false otherwise.

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(utilIsArmedVehicle),_this);

if !assert(params[
    ["_vehicle", objNull, ["", objNull]]
]) exitWith { false };
if (_vehicle isEqualType objNull && { isNull _vehicle }) exitWith { false };

private _config = if (_vehicle isEqualType "") then {
    configFile >> "CfgVehicles" >> _vehicle
} else {
    configOf _vehicle
};

("true" configClasses(_config >> "Turrets")) findIf {
    getArray(_x >> "magazines") findIf {
        // "type" == 0 means it's a weapon, not e.g. a chaff/flare dispenser
        getNumber(configFile >> "CfgMagazines" >> _x >> "type") == 0;
    } != -1;
} != -1;
