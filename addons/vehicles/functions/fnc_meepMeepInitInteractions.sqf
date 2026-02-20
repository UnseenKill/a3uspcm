#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepInitInteractions

Description:
    Initialize scroll-wheell menu interactions for meep meep

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
TRACE_1(QFUNC(meepMeepInitInteractions),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

private _actionId = _object addAction[
    LLSTRING(MeepMeep_Action_DisplayName),
    { call FUNC(meepMeepDoAction) }, nil, 6,
    true, true, "",
    QUOTE([ARR_2(_originalTarget,_this)] call FUNC(meepMeepCanDoAction))
];

_object setUserActionText[
    _actionId, LLSTRING(MeepMeep_Action_DisplayName),
    format["<img size='2' image='%1' />", QPATHTOEF(assets,ui\vehicles-icon-meepmeep.paa)]
];

nil;
