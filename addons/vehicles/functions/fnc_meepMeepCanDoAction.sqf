#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepCanDoAction

Description:
    Scroll-wheel menu interaction callback condition for meep meep action.

Parameters:
    0: _target - The original target object <OBJECT>
    1: _player - The player object <OBJECT>

Optional:

Returns:
    <BOOL> True if the action should be shown, false if not.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepCanDoAction),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};
if !assert(!isNull _player) exitWith {};

(alive _target) && { _player isEqualTo driver _target } &&
{ speed _target < 10 } &&
{ _target getVariable[QGVAR(meepMeepActiveUntil), 0] > diag_tickTime };
