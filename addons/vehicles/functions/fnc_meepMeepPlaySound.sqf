#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepPlaySound

Description:
    Play a sound for the Meep Meep feature.

Parameters:
    0: _target - Sound source <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepPlaySound),_this);

if !assert(params[
    ["_target", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};

private _sound = [QGVAR(MeepMeep), QGVAR(TruckHorn)] select(random 1 < 0.9);
playSound _sound;
[_target, _sound] remoteExec["say3D"];

nil;
