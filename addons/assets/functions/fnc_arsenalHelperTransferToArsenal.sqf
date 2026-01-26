#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_arsenalHelperTransferToArsenal

Description:
    Wrapper around boxX centered inventory dumping function from A3U.

Parameters:
    0: _object - Helper sign <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(arsenalHelperTransferToArsenal),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

private _vehicles = nearestObjects[_object, ["Air", "LandVehicle", "ReammoBox_F"], 20] select {
    (!unitIsUAV _x) && { !(_x isKindOf "StaticWeapon") } && { !(_x in[boxX, vehicleBox]) }
};

TRACE_1(QFUNC(arsenalHelperTransferToArsenal),_vehicles);

if (_vehicles isEqualTo []) exitWith {
    playSound "A3AP_UiFailure";
	[
        localize "STR_A3A_ammunition_transfer_header",
        format[localize "STR_A3A_ammunition_transfer_veh_empty", getText(configOf vehicleBox >> "displayName")]
    ] call A3A_fnc_customHint;
};

[_vehicles select 0, boxX] remoteExec["A3A_fnc_ammunitionTransfer", 2];

nil;
