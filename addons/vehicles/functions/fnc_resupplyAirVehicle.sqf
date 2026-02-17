#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_resupplyAirVehicle

Description:
    Execute resupply for air vehicle.

Parameters:
    0: _vehicle - Target air vehicle <OBJECT>
    1: _unit - Unit piloting the vehicle <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(resupplyAirVehicle),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]],
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _unit) exitWith {};

if (!isTouchingGround _vehicle) exitWith {
    [_unit, LLSTRING(Resupply_UAVPilot_AnnounceNoResupplyAirborne_Text)] call FUNC(resupplyPilotAnnounce);
};

if (isEngineOn _vehicle) exitWith {
    [_unit, LLSTRING(Resupply_UAVPilot_AnnounceNoResupplyEngineOn_Text)] call FUNC(resupplyPilotAnnounce);
};

private _marker = [_vehicle, 750] call FUNCMAIN(utilNearestFriendlyMarker);
if (_marker isEqualTo "") exitWith {
    [_unit, LLSTRING(Resupply_UAVPilot_AnnounceNoResupplyNoMarker_Text)] call FUNC(resupplyPilotAnnounce);
};

if !(_vehicle inArea _marker) exitWith {
    [_unit, format[LLSTRING(Resupply_UAVPilot_AnnounceNoResupplyTooFar_Text), _marker]] call FUNC(resupplyPilotAnnounce);
};

if (GVAR(resupplyRequireEngineer) && { !([_marker] call FUNC(resupplyCheckEngineer)) }) exitWith {
    [_unit, LLSTRING(Resupply_UAVPilot_AnnounceNoResupplyNoEngineer_Text)] call FUNC(resupplyPilotAnnounce);
};

private _resupplied = [];

if (!GVAR(resupplyUseGarageBoxMethod) || { HR_GRG_hasAmmoSource }) then {
    [_vehicle, 1] remoteExec["setVehicleAmmo", _vehicle];
    _resupplied pushBack LLSTRING(Resupply_Type_AmmoYes);
};

if (!GVAR(resupplyUseGarageBoxMethod) || { HR_GRG_hasRepairSource }) then {
    _vehicle setDamage 0;
    _resupplied pushBack LLSTRING(Resupply_Type_RepairYes);
};

if (!GVAR(resupplyUseGarageBoxMethod) || { HR_GRG_hasFuelSource }) then {
    [_vehicle] remoteExecCall["HR_GRG_fnc_refuelVehicleFromSources", 2];
    _resupplied pushBack LLSTRING(Resupply_Type_FuelYes);
};

if (_resupplied isEqualTo []) exitWith {
    [_unit, LLSTRING(Resupply_UAVPilot_AnnounceResupplyNothing_Text)] call FUNC(resupplyPilotAnnounce);
};

[_unit, format[LLSTRING(Resupply_UAVPilot_AnnounceResupplyComplete_Text), _resupplied joinString ", "]] call FUNC(resupplyPilotAnnounce);

nil;
