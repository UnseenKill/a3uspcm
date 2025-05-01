#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilIsArmedVehicle

Description:
    Checks if the vehicle is armed or not.

Parameters:
    0: _vehicle - Vehicle <OBJECT>

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

params[
    ["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith { false };

magazinesAllTurrets[_vehicle, true] findIf {
    _x params["_magName"];
    // "type" == 0 means it's a weapon, not e.g. a chaff/flare dispenser
    (getNumber(configFile >> "CfgMagazines" >> _magName >> "type") == 0)
} >= 0;
