#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_deliverAirdrop

Description:
    Delivers an airdrop container to a specified position.

Parameters:
    0: _container - Airdrop container object <OBJECT>
    1: _position - Position where the airdrop will be delivered <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(deliverAirdrop),_this);

if !assert(params[
    ["_container", nil, [objNull]],
    ["_positionDestination", nil, [[]], 3]
]) exitWith {};

// Loot helicopter code copy

private _positionOrigin = getPosATL _container;

private _angle = [_positionOrigin, _positionDestination] call BIS_fnc_dirTo;
private _angleOrigin = _angle - 180;

private _intermediatePosition = [_positionDestination, 200, _angle] call BIS_fnc_relPos;

private _originPosition = [_positionOrigin, 1500, _angleOrigin] call BIS_fnc_relPos;
private _finPosition = [_positionDestination, 1500, _angle] call BIS_fnc_relPos;

private _heliType = "a3a_C_Heli_Transport_02_F";
private _heliData = [_originPosition, _angle, _heliType, civilian] call A3A_fnc_spawnVehicle;
private _heli = _heliData select 0;
private _heliCrew = _heliData select 1;
private _groupHeli = _heliData select 2;

if (_heliType isEqualTo []) exitWith {
	["Support", "A helicopter is not available due to template issues. Apologies! You have been refunded."] call A3A_fnc_customHint;
	[] call FUNC(refundRemoteAccessFee);
};

sleep 6;

_heli setPosATL [getPosATL _heli select 0, getPosATL _heli select 1, 600];
_heli disableAI "TARGET";
_heli disableAI "AUTOTARGET";
_heli flyInHeight 120;
_heli allowDamage false;
_heli enableRopeAttach true;

#ifndef __A3USPCM_PRODUCTION__
allCurators apply { _x addCuratorEditableObjects[[_heli], false] };
#endif // __A3USPCM_PRODUCTION__

sleep 2;
private _lootCratePosition = (getPosASL _heli) vectorAdd [0, 0, -10];
private _lootCrate = _container;
_lootCrate setPosASL _lootCratePosition;
_lootCrate allowDamage false;
[_lootCrate] call A3A_Logistics_fnc_addLoadAction;
_heli setSlingLoad _lootCrate;

driver _heli sideChat LLSTRING(HelicopterPilotAnnounceDelivery);

private["_wp1","_wp2","_wp3","_wp4"];

_wp1 = group _heli addWaypoint [_positionOrigin, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "CARELESS";

_wp2 = group _heli addWaypoint [_intermediatePosition, 1];
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "(vehicle this) flyInHeight 250;"];

waitUntil {_heli distance2D _positionDestination < 250 || {!alive _heli || !(canMove _heli) || {!([(driver _heli)] call A3A_fnc_canFight)}}};

if (!alive _heli || !(canMove _heli) || {!([(driver _heli)] call A3A_fnc_canFight)}) exitWith {
	INFO_2("Helicopter is unable to loot area (#1). Positions: %1, %2",str _positionOrigin,str _positionDestination);
};

_wp3 = group _heli addWaypoint [_positionDestination, 2];
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointType "MOVE";
_wp3 setWaypointStatements ["true", "(vehicle this) flyInHeight 50;"];

private _timeOut = time + 45;
waitUntil {time > _timeOut};

if (!alive _heli || !(canMove _heli) || {!([(driver _heli)] call A3A_fnc_canFight)}) exitWith {
	INFO_2("Helicopter is unable to loot area (#2). Positions: %1, %2",str _positionOrigin,str _positionDestination);
};

_heli setSlingLoad objNull;

_timeOut = time + 3.5;
waitUntil {time > _timeOut};

private _para = createVehicle ["B_parachute_02_F", [0,0,0], [], 0, "NONE"];
_para setDir getDir _lootCrate;
_para setPos getPos _lootCrate;
_lootCrate attachTo [_para, [0, 0, -1.2]];

[_lootCrate, _para] spawn {
	params ["_obj","_para"];

	waitUntil {
		sleep 0.01;
		(((position _obj) select 2) < 2)
		||
		{ isNull _para }
		||
		{ (count (lineIntersectsWith [getPosASL _obj, (getPosASL _obj) vectorAdd [0, 0, -0.5], _obj, _para])) > 0 }
	};

	_para disableCollisionWith _obj;
	_obj setVectorUp [0,0,1];
	_obj setVelocity [0,0,0];
	detach _obj;
    [] call FUNC(finishAirdrop);

	//mark landing with smoke
	(selectRandom ["SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"]) createVehicle (position _obj);

	if(sunOrMoon < 1) then {
		(selectRandom ["Chemlight_green", "Chemlight_red", "Chemlight_yellow", "Chemlight_blue"]) createVehicle (position _obj);
	};

	if (!isNull _para) then {deleteVehicle _para};
};

_wp4 = group _heli addWaypoint [_finPosition, 4];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointSpeed "FULL";
_wp4 setWaypointStatements ["true", "(vehicle this) flyInHeight 100;"];

private _timeOut = time + 600;
waitUntil { sleep 2; (currentWaypoint group _heli == 5) or (time > _timeOut) or !(canMove _heli)};

if !(canMove _heli) then { sleep 600 };
deleteVehicle _heli;
{deleteVehicle _x} forEach _heliCrew;
deleteGroup _groupHeli;

nil;
