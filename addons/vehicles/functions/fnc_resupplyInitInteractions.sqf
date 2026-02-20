#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_resupplyInitInteractions

Description:
    Initialize scroll-wheell menu interactions for resupply vehicles

Parameters:
    0: _object - The vehicle object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(resupplyInitInteractions),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

private _actionId = _object addAction[
    LLSTRING(AirVehicleResupply_Action_DisplayName),
    { call FUNC(doAirVehicleResupply) }, nil, 6,
    true, true, "",
    QUOTE([ARR_2(_originalTarget,_this)] call FUNC(canAirVehicleResupply))
];

_object setUserActionText[
    _actionId, LLSTRING(AirVehicleResupply_Action_DisplayName),
    "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa' />"
];

nil;
