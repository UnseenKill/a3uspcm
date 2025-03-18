#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscFixAirSupportVehicles

Description:
    Remove clunky old planes from air support, add jet.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscFixAirSupportVehicles;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 wants air support fixed",name player);

private _classes = ["B_Plane_Fighter_01_Stealth_F","B_Plane_CAS_01_dynamicLoadout_F"];
private _index = _classes findIf { isClass(configFile >> "CfgVehicles" >> _x) };

if (_index < 0) exitWith { ERROR("no suitable planes found") };

private _class = _classes select _index;

TRACE_1(QFUNCMAIN(miscFixAirSupportVehicles),_class);
A3A_faction_reb set["vehiclesPlane",[_class]];

nil;
